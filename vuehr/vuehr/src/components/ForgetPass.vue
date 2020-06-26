<template>
  <el-dialog title="重置密码" :visible.sync="diaglogVisible" width="36%" >
    <el-form class="loginForm" :model="forgetForm" :rules="forgetRules" label-position="left" label-width="100px" v-loading="loading">
      <el-radio-group v-model="forgetRadio" @change="changeForgetRadio" style="margin-bottom: 30px;">
        <el-radio-button :label="1" >邮箱验证</el-radio-button>
        <el-radio-button :label="2" >手机验证</el-radio-button>
      </el-radio-group>
      <el-form-item prop="id" label="员工ID：">
        <el-input type="text" v-model="forgetForm.id" prefix-icon="el-icon-bank-card" auto-complete="off" placeholder="员工ID"></el-input>
      </el-form-item>
      <el-form-item prop="tel" label="手机：" v-if="isTel1" >
        <el-input  v-model="forgetForm.tel" prefix-icon="el-icon-phone" auto-complete="off" placeholder="手机号"></el-input>
      </el-form-item>
      <el-form-item prop="mail" label="邮箱：" v-else >
        <el-input  v-model="forgetForm.mail" key="mail" prefix-icon="el-icon-message" auto-complete="off" placeholder="邮箱"></el-input>
      </el-form-item>
      <el-form-item prop="checkCode" label="验证码：">
        <el-input type="text" v-model="forgetForm.checkCode" auto-complete="off"  prefix-icon="el-icon-key" placeholder="验证码">
        </el-input>
      </el-form-item>
      <el-form-item>
        <el-button plain style="font-size:14px;width:100%;margin-top:-10px;" @click="sendCode()">点击发送验证码</el-button>
      </el-form-item>
      <el-form-item prop="checkPass1" label="新密码：">
        <el-input type="password" v-model="forgetForm.checkPass1" prefix-icon="el-icon-unlock" auto-complete="off" placeholder="新密码"></el-input>
      </el-form-item>
      <el-form-item prop="checkPass2" label="确认密码：">
        <el-input type="password" v-model="forgetForm.checkPass2" prefix-icon="el-icon-unlock" auto-complete="off" placeholder="确认新密码"></el-input>
      </el-form-item>
      <el-button type="primary" @click="ChangePassword">确认</el-button>
      <el-button  @click="Cancel">取消</el-button>
    </el-form>
  </el-dialog>
</template>

<script>
  import {validatePhone,validateMail,isEngNumLine} from "@/utils/validate";
  import store from '@/store/index.js'
    export default {
        name: "ForgetPass",
        store,
        data(){
          return{
            //忘记密码
            forgetRules:{
              mail:[{required: true,validator:validateMail,trigger:"blur"}],
              tel:[{required: true,message: '请输入手机号',trigger: 'blur'},{validator:validatePhone,trigger:"blur"}],
              checkCode:[{required: true,message: '请输入验证码',trigger: 'blur'}],
              id: [{ required: true,message: '请输入员工id',trigger: 'blur'},{validator:isEngNumLine,trigger:"blur"}],
              checkPass1: [{ required: true,message: '请输入密码',trigger: 'blur'},{validator:isEngNumLine,trigger:"blur"}],
              checkPass2: [{ required: true,message: '请再次输入密码',trigger: 'blur'},
                {validator:(rule,value,callback)=>{
                    if(value===''){callback(new Error('请再次输入密码'))}
                    else if(value!==this.registerForm.checkPass1){callback(new Error('两次输入密码不一致'))}
                    else{callback( )}},trigger:'blur'}
              ],
            },
            forgetRadio:'1',
            forgetForm:{
              id: '',
              checkPass1: '',
              checkPass2: '',
              tel:'',
              mail:'',
              checkCode:'',
            },

            loading : false,
            isTel1:false,

          }

        },
      computed: {
        diaglogVisible () {
          return store.state.diaglogVisible
        }

      },
      methods:{
      /**
       * 切换邮箱验证或手机验证组件
       * */
        changeForgetRadio:function(){
          console.log(!this.isTel1);
          this.isTel1 = !this.isTel1;
        },
        /**
         * 发送手机或邮箱验证码
         *
         */
        sendCode: function() {
          let userid='' ;
          let email='';
          let tel='';
          let obj;
          let target='';

          userid=this.forgetForm.id;
          obj = this.forgetForm;
          if (this.isTel1===true) {
            tel = this.forgetForm.tel;
          }else{
            email = this.forgetForm.mail;
          }
          //手机号验证
          if (this.isTel1) {
            this.axios.post("/message/vcode/register",tel).then(resp => {
              console.log(resp.data);
              console.log(resp.data.status)
              if (resp.data && resp.data.status == 200) {
                console.log(resp);
              }
            });
          }else {//邮箱验证
            this.axios.post("user/register/mail/data",{
              id:obj.id,
              mail:mail,
            }).then(resp => {
              console.log("邮箱验证码API测试");
              if (resp.data && resp.data.status == 200) {
                var data = resp.data.obj;
                console.log(resp);
              }
            });
          }

        },
        //确认修改密码按钮
        ChangePassword:function() {
          console.log("checkCode:" + this.forgetForm.checkCode+"\n"+"newPassWord:" + this.forgetForm.checkPass2);
          var _this = this;

          store.commit('changeLoading',true)

          this.postRequest('/login', {
            username: this.loginForm.username,
            password: this.loginForm.password
          }).then(resp=> {

            store.commit('changeLoading',false)

            if (resp && resp.status == 200) {
              var data = resp.data;
              _this.$store.commit('login', data.obj);
              var path = _this.$route.query.redirect;
              _this.$router
                .replace({path: path == '/' || path == undefined ? '/home' : path});
            }
          });
          store.commit('ChangePassword')

        },
        //取消修改密码按钮
        Cancel() {
          store.commit('Cancel')
        },

      }

    }
</script>

<style scoped>

</style>
