<template>
  <el-form :rules="registerRules" :model="registerForm" ref="registerForm" class="loginForm" label-position="left" label-width="100px" v-loading="loading">
    <h3 class="login_title" style="margin-bottom:24px;">注   册</h3>
    <el-radio v-model="radio" label="1" @change="changeRadio" style="margin:0px 20px 16px 30px;">邮箱注册</el-radio>
    <el-radio v-model="radio" label="2" @change="changeRadio" style="margin-bottom:5px;">手机注册</el-radio>
    <el-form-item prop="tel" label="手机：" v-if="isTel" >
      <el-input  v-model="registerForm.tel" prefix-icon="el-icon-phone" auto-complete="off" placeholder="手机号"></el-input>
    </el-form-item>
    <el-form-item prop="mail" label="邮箱：" v-else >
      <el-input  v-model="registerForm.mail" key="mail" prefix-icon="el-icon-message" auto-complete="off" placeholder="邮箱"></el-input>
    </el-form-item>
    <el-form-item prop="checkCode" label="验证码：">
      <el-input type="text" v-model="registerForm.checkCode" auto-complete="off"  prefix-icon="el-icon-key" placeholder="验证码">
      </el-input>
    </el-form-item>
    <el-form-item>
      <el-button plain style="font-size:14px;width:100%;margin-top:-10px;" @click="sendCode()" :disabled="regDisCodeBtn">{{btntxt}}</el-button>
    </el-form-item>
    <el-form-item prop="id" label="员工ID：">
      <el-input type="text" v-model="registerForm.id" prefix-icon="el-icon-bank-card" auto-complete="off" placeholder="员工ID"></el-input>
    </el-form-item>
    <el-form-item prop="key" label="账号：">
      <el-input type="text" v-model="registerForm.key" prefix-icon="el-icon-user" auto-complete="off" placeholder="用户名"></el-input>
    </el-form-item>

    <el-form-item prop="checkPass1" label="密码：">
      <el-input type="password" v-model="registerForm.checkPass1" prefix-icon="el-icon-unlock" auto-complete="off" placeholder="新密码"></el-input>
    </el-form-item>
    <el-form-item prop="checkPass2" label="确认密码：">
      <el-input type="password" v-model="registerForm.checkPass2" prefix-icon="el-icon-unlock" auto-complete="off" placeholder="确认新密码"></el-input>
    </el-form-item>
    <el-button type="primary" style="width: 100%" @click="registerClick">注册</el-button>
  </el-form>
</template>

<script>
  import {validatePhone,validateMail,isEngNumLine,isNum} from "@/utils/validate";
  import axios from 'axios'
    export default {
        name: "Register",

        data(){
          return{
            //注册
            registerForm:{
              id: '',
              key: '',
              checkPass1: '',
              checkPass2: '',
              tel:'',
              mail:'',
              checkCode:'',
            },
            registerRules: {
              mail:[{required: true,validator:validateMail,trigger:"blur"}],
              tel:[{required: true,message: '请输入手机号',trigger: 'blur'},{validator:validatePhone,trigger:"blur"}],
              checkCode:[{required: true,message: '请输入验证码',trigger: 'blur'}],
              id: [{ required: true,message: '请输入员工id',trigger: 'blur'},{validator:isNum,trigger:"blur"}],
              key: [{ required: true,message: '请输入用户名',trigger: 'blur'},
                {validator:isEngNumLine,message: '请输入字母数字或下划线',trigger:'blur'}],
              checkPass1: [{ required: true,message: '请输入密码',trigger: 'blur'},{validator:isEngNumLine,trigger:"blur"}],
              checkPass2: [{ required: true,message: '请再次输入密码',trigger: 'blur'},
                {
                  validator:(rule,value,callback)=>{
                    if(value===''){callback(new Error('请再次输入密码'))}
                    else if(value!==this.registerForm.checkPass1){callback(new Error('两次输入密码不一致'))}
                    else{callback( )}},trigger:'blur'}
              ],
            },
            radio:'1',
            isTel:false,
            regDisCodeBtn:false,
            btntxt:'获取验证码',
            time:60,
            loading : false
          }
        },
      methods:{
        //确认注册按钮
        registerClick:function(){
          console.log("checkCode:" + this.registerForm.checkCode+"\n"+"newPassWord:" + this.registerForm.checkPass2);

        },
        changeRadio:function(){
          if(isTel===true)
            this.isTel=false
          else
            this.isTel=true
        },
        /**
         * 发送手机或邮箱验证码
         *
         */
        sendCode: function() {
          this.time = 0;//计时器
          this.regDisCodeBtn = true;
          this.timer();

          //手机号验证
          if (this.isTel) {
            axios({
              url:'/message/vcode/register',
              method: 'post',
              data: {tel:this.registerForm.tel},
              headers:{
                'Content-Type':'application/json'
              }
	          }).then(resp => {
              console.log(resp.data);
              console.log(resp.data.status)
              if (resp.data && resp.data.result == true) {
                console.log("手机验证码API测试"+resp);
              }else{
                this.$message({message:"发送失败",type:"error"})
              }
            });
          }else{//邮箱验证
            axios({
              url:'/mail/vcode/register',
              method: 'post',
              data: {mail:this.registerForm.mail},
              headers:{
                'Content-Type':'application/json'
              }
	          }).then(resp => {
              var data = resp.data;
              if (resp.data && resp.data.result == true) {
                this.$message.success("发送成功")
              }else{
                this.$message.error(data.reason);
              }
            });
          }
        },
        //注册
      registerClick:function(){
        console.log("checkCode:" + this.registerForm.checkCode+"\n"+"newPassWord:" + this.registerForm.checkPass2);
        let url="";
        let datas={};
        if(this.isTel){
          url="";
          datas={
            workId:this.registerForm.id,
            password:this.registerForm.checkPass2,
            vcode:this.registerForm.checkCode,
            phone:this.registerForm.tel
          }
        }else{
          url="/user/register/mail/operation"
          datas={
            workId:this.registerForm.id,
            password:this.registerForm.checkPass2,
            vcode:this.registerForm.checkCode,
            mail:this.registerForm.mail
          }
        }
        this.$refs.registerForm.validate(async valid=>{
          if (valid) {
            console.log("注册表单验证测试成功！");
            axios({
              url:url,
              method: 'post',
              data: datas,
              headers:{
                'Content-Type':'application/json'
              }
	          }).then(resp=>{
              let data = resp.data;
              if (resp.data && resp.data.result == true) {
                  this.$message.success("注册成功！");
              }else{
                  this.$message.error(data.reason);
              }
            });
          }else{
            this.$message.error("请按正确的格式填写注册表单！");
          }
        })
      },
         //发送验证码倒计时
      timer:function() {
        if (this.time > 0) {
              this.time--;
              this.btntxt="("+this.time+")s 后重新获取";
              setTimeout(this.timer, 1000);
        } else{
              this.time=0;
              this.btntxt="获取验证码";
              this.disabled=true;
              this.regDisCodeBtn = false;
        }
      },
      }

    }
</script>

<style scoped>

</style>
