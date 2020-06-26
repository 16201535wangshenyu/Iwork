<template>
  <el-container>
    <el-main type="flex" class="row-bg" justify="center">


        <div  >
            <img style = "width:120px;height:120px;border-radius: 100%" :src="user.userFace"/>
        </div>

        <el-form ref="form" :model="user" v-loading="formLoading" label-width="80px" class="form" >
         <el-row>
              <el-col :span="6">
                  <el-form-item label="工号" prop="userUid">
                    <el-input disabled v-model="user.workId" @change="update"></el-input>
                  </el-form-item>
                  <el-form-item disabled label="姓名" prop="realName">
                    <el-input v-model="user.realName" @change="update"></el-input>
                  </el-form-item>
                  <el-form-item label="昵称">
                    <el-input v-model="user.nickName" @change="update"></el-input>
                  </el-form-item>
                  <el-form-item  label="性别">
                    <el-radio-group disabled v-model="user.gender" @change="update">
                      <el-radio label="男">男</el-radio>
                      <el-radio label="女">女</el-radio>
                    </el-radio-group>
                  </el-form-item>
                  <el-form-item  label="工龄">
                    <el-input disabled v-model="user.workAge" @change="update"></el-input>
                  </el-form-item>

                  <el-form-item label="邮箱">
                    <el-input v-model="user.mail" @change="update"></el-input>
                  </el-form-item>
                  <el-form-item  label="身份证号">
                    <el-input disabled v-model="user.idCard" @change="update"></el-input>
                  </el-form-item>
              </el-col>
              <el-col :span="6">


                <el-form-item label="民族">
                  <el-select v-model="user.nation.nationUid" placeholder="请选择民族" @change="update">
                    <el-option
                      v-for="item in nations"
                      :key="item.nationUid"
                      :label="item.name"
                      :value="item.nationUid">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="籍贯">
                  <el-input v-model="user.nativePlace" @change="update"></el-input>
                </el-form-item>
                <el-form-item label="部门">
                  <el-input  disabled v-model="user.oweDepartment.name"></el-input>
                </el-form-item>
                <el-form-item label="职称">
                  <el-select v-model="user.jobLevel.jobLevelUid" disabled placeholder="请选择职称">
                    <el-option
                      v-for="item in joblevels"
                      :key="item.jobLevelUid"
                      :label="item.name"
                      :value="item.jobLevelUid">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="职位">
                  <el-select v-model="user.position.positionUid" disabled placeholder="请选择职位">
                    <el-option
                      v-for="item in positions"
                      :key="item.positionUid"
                      :label="item.name"
                      :value="item.positionUid">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="政治面貌">
                  <el-select v-model="user.politicsStatus.politicsStatusUId" disabled placeholder="请选择政治面貌">
                    <el-option
                      v-for="item in politics"
                      :key="item.politicsStatusUId"
                      :label="item.name"
                      :value="item.politicsStatusUId">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="联系电话">
                  <el-input v-model="user.phone" disabled></el-input>
                </el-form-item>

              </el-col>
             <el-col :span="6">
               <el-form-item label="生日">
                 <el-date-picker type="date" placeholder="选择日期" v-model="user.birthday" @change="update" style="width: 100%;"></el-date-picker>
               </el-form-item>
               <el-form-item label="入职时间">
                 <el-date-picker type="date" placeholder="选择日期" disabled v-model="user.beginDate" style="width: 100%;"></el-date-picker>

               </el-form-item>
               <el-form-item label="合同期限">
                 <el-input v-model="user.contractTerm" disabled></el-input>
               </el-form-item>
               <el-form-item label="合同起始">
                 <el-date-picker type="date" placeholder="选择日期" disabled v-model="user.beginContract" style="width: 100%;"></el-date-picker>

               </el-form-item>
               <el-form-item label="合同终止">
                 <el-date-picker type="date" placeholder="选择日期" disabled v-model="user.endContract" style="width: 100%;"></el-date-picker>

               </el-form-item>
               <el-form-item label="转正日期">
                 <el-date-picker type="date" placeholder="选择日期" disabled v-model="user.conversionTime" style="width: 100%;"></el-date-picker>

               </el-form-item>
               <el-form-item label="离职日期">
                 <el-date-picker type="date" placeholder="选择日期" disabled v-model="user.notWorkDate" style="width: 100%;"></el-date-picker>
               </el-form-item>
             </el-col>
           <el-col :span="6">
             <el-form-item label="本科专业">
               <el-input v-model="user.specialty" disabled></el-input>
             </el-form-item>
             <el-form-item label="最高学历">
               <el-input v-model="user.tiptopDegree" disabled></el-input>
             </el-form-item>
             <el-form-item label="毕业院校">
               <el-input v-model="user.school" disabled></el-input>
             </el-form-item>
             <el-form-item label="员工状态" >
               <el-input v-model="user.employeeState.employeeState" disabled></el-input>
             </el-form-item>
             <el-form-item label="聘用形式" >
               <el-radio-group v-model="user.engageForm" disabled>
                 <el-radio label="劳动合同">劳动合同</el-radio>
                 <el-radio label="劳务合同">劳务合同</el-radio>
               </el-radio-group>
             </el-form-item>
             <el-form-item label="婚姻状况">
               <el-radio-group v-model="user.wedLock" @change="update">
                 <el-radio label="已婚">已婚</el-radio>
                 <el-radio label="未婚">未婚</el-radio>
                 <el-radio label="离异">离异</el-radio>
               </el-radio-group>
             </el-form-item>
             <el-form-item label="联系地址" @change="update">
               <el-input v-model="user.address"></el-input>
             </el-form-item>
           </el-col>
         </el-row>
        </el-form>
    </el-main>
  </el-container>
</template>

<script>
    export default {
        data(){
          return{
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
            formLoading:false,
            nations: [],
            politics: [],
            positions: [],
            joblevels: [],
            degrees: [{id: 4, name: '大专'}, {id: 5, name: '本科'}, {id: 6, name: '硕士'}, {id: 7, name: '博士'}, {id: 3, name: '高中'}, {id: 2, name: '初中'}, {id: 1, name: '小学'}, {id: 8, name: '其他'}],
            deps: [],
            defaultProps: {
              label: 'name',
              isLeaf: 'leaf',
              children: 'childrenList'
            }
          }
        },
      methods:{

        wedlockChange(){
          console.log("我改变了！")
        },
        loadUserInfo(){
          var _this = this;
          _this.formLoading = true;
          if(JSON.parse(window.localStorage.getItem('user' || '[]')).user == null)
             return ;
          _this.user = JSON.parse(window.localStorage.getItem('user' || '[]')).user;
          console.log("加载用户的信息")
          console.log(_this.user)
          this.getRequest("/employee/basic/basicdata").then(resp => {
            _this.formLoading = false;
            if (resp && resp.status == 200) {
              var data = resp.data;
              _this.nations = data.nations;
              _this.politics = data.politics;
              _this.deps = data.deps;
              _this.positions = data.positions;
              _this.joblevels = data.joblevels;
            }
          })

          /* this.putRequest("/system/hr/id/" + ).then(resp=> {
            console.log("加载用户的数据")
            console.log(resp.data)
          })*/

        },
        update () {
          var _this = this;

          _this.formLoading = true;
          _this.user.birthday = new Date(_this.user.birthday);
          _this.user.conversionTime = new Date(_this.user.conversionTime);
          _this.user.endContract = new Date(_this.user.endContract);
          _this.user.beginContract = new Date(_this.user.beginContract);
          _this.user.beginDate = new Date(_this.user.beginDate);
          _this.user.notWorkDate = new Date(_this.user.notWorkDate)
          let emp = {
            id : _this.user.userUid,
            name : _this.user.realName,
            gender : _this.user.gender,
            birthday : _this.user.birthday,
            idCard : _this.user.idCard,
            wedlock : _this.user.wedLock,
            idCard : _this.user.idCard,
            nationId : _this.user.nation.nationUid,
            nativePlace : _this.user.nativePlace,
            politicId : _this.user.politicsStatus.politicsStatusUId,
            email : _this.user.mail,
            phone : _this.user.phone,
            address : _this.user.address,
            departmentId : _this.user.oweDepartment.departmentUid,
            departmentName : _this.user.oweDepartment.name,
            jobLevelId : _this.user.jobLevel.jobLevelUid,
            posId : _this.user.position.positionUid,
            engageForm : _this.user.engageForm,
            tiptopDegree :_this.user.tiptopDegree ,
            specialty :_this.user.specialty,
            school : _this.user.school,
            beginDate : _this.user.beginDate,
            workID : _this.user.workId,
            contractTerm : _this.user.contractTerm ,
            conversionTime : _this.user.conversionTime,
            endContract : _this.user.endContract,
            beginContract : _this.user.beginContract
          }
          console.log("user以改变")
          console.log(typeof (_this.user.nation))
          _this.putRequest("/employee/basic/emp",emp ).then(resp => {
            _this.formLoading = false;

            if (resp && resp.status == 200) {

              _this.dialogVisible = false;

            }
          })


        }
      },
      watch:{
        /*user:this.update(newUser,oldUser)*/
      },
      mounted: function (){
        this.loadUserInfo();
      },


    }
</script>

<style scoped>
  .el-row {
    margin-bottom: 20px;

  }
  .form{

    margin-left: 6%;
    margin-top:30px;
    padding-top: 0px;
    position:absolute;

  }
  .img{

  }
  el-input{
    width:10%;
  }

</style>
