<template>
  <div class="menu">
    <el-button @click="checkIn()">打卡</el-button>
    <el-button @click="dialogFormVisible = true">申请请假/调休</el-button>
    <el-dialog class="block" :visible.sync="dialogFormVisible" title="申请">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="申请类型">
          <el-select v-model="value" placeholder="请选择">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="选择日期">
          <el-date-picker
            value-format="yyyy-MM-dd"
            v-model="daterange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="申请内容">
          <el-input
            placeholder="请输入内容"
            v-model="input"
            clearable>
          </el-input>
        </el-form-item>
        <el-form-item class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="applyFor()">确 定</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
  import {getRequest, postRequest} from "../../../utils/api";

  export default {
    name: 'UserMenu',
    data() {
      return {
        form: {},
        input: '',
        dialogFormVisible: false,
        daterange: '',
        options: [{
          value: '1',
          label: '请假'
        }, {
          value: '2',
          label: '调休'
        }, {
          value: '3',
          label: '出差'
        }],
        value: '',
        checkType :'',
        user: {
          userUid: '',
          realName: '',
          password: '',
          nickName: '',
          gender: '',
          birthday: '',
          wedLock: '',
          nation: [],
          nativePlace: '',
          politicsStatus: [],
          oweDepartment: [],
          jobLevel: [],
          position: [],
          engageForm: '',
          specialty: '',
          tiptopDegree: '',
          school: '',
          beginDate: '',
          workId: '',
          contractTerm: '',
          beginContract: '',
          endContract: '',
          conversionTime: '',
          notWorkDate: '',
          enabled:'',
          workAge:'',
          phone:'',
          mail:'',
          idCard:'',
          address:'',
          employeeState:[],
          userFace:'',
          remark:''
        },
      }

    },
    mounted() {
      var _this = this;
      _this.user = JSON.parse(window.localStorage.getItem('user' || '[]')).user;
    },
    methods: {

      checkIn() {
        var _this = this;

        var currentTime = Date();
        var time1 = new Date();
        time1.setHours(7);
        var time2 = new Date();
        time2.setHours(11);
        var time3 = new Date();
        time3.setHours(13);
        var time4 = new Date();
        time4.setHours(17);

        console.log(time1)
        console.log(time2)
        console.log(time3)
        console.log(time4)
        if (time1 < currentTime < time2 && time3 < currentTime < time4) {
          _this.checkType = '出勤'
        }else{
          _this.checkType = '迟到'
        }
          this.postRequest('/user/basic/check', {
            userId:_this.user.userUid ,
            type:_this.checkType ,
            date: currentTime,

          })
            .then(response => {
              console.log(response)
            })
            .catch(error => {
              console.log(error)
            })


      },
      applyFor() {
        console.log(this.value)
        console.log(this.daterange[0])
        console.log(this.input)
        postRequest('/user/leave/insert', {
          user: this.user.userUid,
          value: this.value,
          startTime: this.daterange[0],
          endTime: this.daterange[1],
          input: this.input

        })
          .then(response => {
            console.log(response)
            this.$message.success("已提交申请")
          })
          .catch(error => {
            console.log(error)
            this.$message.error("提交申请失败")
          })
        this.dialogFormVisible = false;
      }

    }







  }

</script>

<style scoped>
  .menu {
    background: #fff;
    width: 300px;
    margin-top: 15px;
    text-align: left;
    color: #737373
  }
</style>
