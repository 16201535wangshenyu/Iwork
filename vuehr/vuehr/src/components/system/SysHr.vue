<template>
  <div style="margin-top: 10px" v-loading="fullloading">
    <div style="margin-bottom: 10px;display: flex;justify-content: center;align-items: center">
      <el-input
        placeholder="默认展示部分用户，可以通过用户名搜索更多用户..."
        prefix-icon="el-icon-search"
        size="small"
        style="width: 400px;margin-right: 10px"
        v-model="keywords">
      </el-input>
      <el-button size="small" type="primary" icon="el-icon-search" @click="searchClick">搜索</el-button>
    </div>
    <div style="display: flex;justify-content: space-around;flex-wrap: wrap;text-align: left">
      <el-card style="width: 350px;margin-bottom: 20px" v-for="(item,index) in hrs" :key="item.user.userUid"
               v-loading="cardLoading[index]">
        <div slot="header" class="clearfix">
          <span>{{item.user.realName}}</span>
          <el-button type="text"
                     style="color: #f6061b;margin: 0px;float: right; padding: 3px 0;width: 15px;height:15px"
                     icon="el-icon-delete" @click="deleteHr(item.user.userUid)"></el-button>
        </div>
        <div>
          <div style="width: 100%;display: flex;justify-content: center">
            <img :src="item.user.userFace" alt="item.realName" style="width: 70px;height: 70px;border-radius: 70px">
          </div>
          <div style="margin-top: 20px">
            <div><span class="user-info">用户名:{{item.user.realName}}</span></div>
            <div><span class="user-info">手机号码:{{item.user.phone}}</span></div>
            <div><span class="user-info">邮箱:{{item.user.mail}}</span></div>
            <div><span class="user-info">地址:{{item.user.address}}</span></div>
            <div class="user-info" style="display: flex;align-items: center;margin-bottom: 3px">
              用户状态:
              <el-switch
                style="display: inline;margin-left: 5px"
                v-model="item.user.enabled"
                active-color="#13ce66"
                active-text="启用"
                inactive-color="#aaaaaa"
                :key="item.user.userUid"
                inactive-text="禁用"
                @change="switchChange(item.user.enabled,item.user.userUid,item.user.workId,index)"
                >
              </el-switch>
            </div>
            <div class="user-info">
              用户角色:
              <el-tag
                v-for="role in item.roles"
                :key="role.id"
                type="success"
                size="mini"
                style="margin-right: 5px"
                :disable-transitions="false">{{role.nameZh}}
              </el-tag>
              <el-popover
                v-loading="eploading[index]"
                placement="right"
                title="角色列表"
                width="200"
                @hide="updateHrRoles(item.user.userUid,index)"
                :key="item.user.userUid"
                trigger="click">
                <el-select v-model="selRoles" multiple placeholder="请选择角色">
                  <el-option
                    v-for="ar in allRoles"
                    :key="ar.roleUid"
                    :label="ar.nameZh"
                    :value="ar.roleUid">
                  </el-option>
                </el-select>
                <el-button type="text" icon="el-icon-more" style="color: #09c0f6;padding-top: 0px" slot="reference"
                           @click="loadSelRoles(item.roles,index)" :disabled="moreBtnState"></el-button>
<!--                <i class="el-icon-more" style="color: #09c0f6;cursor: pointer" slot="reference"
                   @click="loadSelRoles(item.roles,index)" disabled="true"></i>-->
              </el-popover>
            </div>
            <div><span class="user-info">备注:{{item.user.remark}}</span></div>
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>
<script>
  export default{
    data(){
      return {
        keywords: '',
        fullloading: false,
        hrs: [],
        cardLoading: [],
        eploading: [],
        allRoles: [],
        moreBtnState:false,
        selRoles: [],
        selRolesBak: []
      }
    },
    mounted: function () {
      this.initCards();
      this.loadAllRoles();
    },
    methods: {
      searchClick(){
        this.initCards();
        this.loadAllRoles();
      },
      updateHrRoles(hrId, index){
        this.moreBtnState = false;
        var _this = this;
        if (this.selRolesBak.length == this.selRoles.length) {
          for (var i = 0; i < this.selRoles.length; i++) {
            for (var j = 0; j < this.selRolesBak.length; j++) {
              if (this.selRoles[i] == this.selRolesBak[j]) {
                this.selRolesBak.splice(j, 1);
                break;
              }
            }
          }
          if (this.selRolesBak.length == 0) {
            return;
          }
        }
        this.eploading.splice(index, 1, true);
        console.log("修改用户角色数据");
        console.log(hrId);
        console.log(this.selRoles);
        this.putRequest("/system/hr/roles", {
          hrId: hrId,
          rids: this.selRoles
        }).then(resp=> {
          _this.eploading.splice(index, 1, false);
          if (resp && resp.status == 200) {
            var data = resp.data;

            if (data.status == 200) {
              console.log("更新hr");
              console.log(hrId);
              console.log(index);
              _this.refreshHr(hrId, index);

            }
          }
        });
      },
      refreshHr(hrId, index){
        var _this = this;
        _this.cardLoading.splice(index, 1, true);
        this.putRequest("/system/hr/id/" + hrId).then(resp=> {
          _this.cardLoading.splice(index, 1, false);
          _this.hrs.splice(index, 1, resp.data);
        })
      },
      loadSelRoles(hrRoles, index){
        this.moreBtnState = true;
        this.selRoles = [];
        this.selRolesBak = [];
        hrRoles.forEach(role=> {
          this.selRoles.push(role.roleUid);
          this.selRolesBak.push(role.roleUid)
        })
      },
      loadAllRoles(){
        var _this = this;
        this.getRequest("/system/hr/roles").then(resp=> {
          _this.fullloading = false;
          if (resp && resp.status == 200) {
            console.log("加载的所有的角色");
            console.log(resp.data);
            _this.allRoles = resp.data;
          }
        })
      },
      switchChange(newValue, hrId,workId, index){
        console.log("执行了改变方法");
        var _this = this;
        _this.cardLoading.splice(index, 1, true);
        this.putRequest("/system/hr/", {
          enabled: newValue,
          id: hrId,
          workID:workId
        }).then(resp=> {
          _this.cardLoading.splice(index, 1, false);
          if (resp && resp.status == 200) {
            var data = resp.data;

            if (data.status == 'error') {
              _this.refreshHr(hrId, index);
            }
          } else {
            _this.refreshHr(hrId, index);
          }
        })
      },
      initCards(){
        this.fullloading = true;
        var _this = this;
        var searchWords;
        if (this.keywords === '') {
          searchWords = 'all';
        } else {
          searchWords = this.keywords;
        }
        this.getRequest("/system/hr/" + searchWords).then(resp=> {
          if (resp && resp.status == 200) {
            _this.hrs = resp.data;
            console.log("hrs数据")
            console.log(resp.data)

            var length = resp.data.length;
            _this.cardLoading = Array.apply(null, Array(length)).map(function (item, i) {
              return false;
            });
            _this.eploading = Array.apply(null, Array(length)).map(function (item, i) {
              return false;
            });
          }
        })
      },
      deleteHr(hrId){
        var _this = this;
        this.fullloading = true;
        console.log("执行删除的人的Id")
        console.log(hrId)
        this.deleteRequest("/system/hr/" + hrId).then(resp=> {
          _this.fullloading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            if (data.status == 'success') {
              _this.initCards();
              _this.loadAllRoles();
            }
          }
        })
      }
    }
  }
</script>
<style>
  .user-info {
    font-size: 12px;
    color: #09c0f6;
  }
</style>
