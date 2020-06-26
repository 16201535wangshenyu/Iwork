<template>
  <el-tabs type="border-card" class="login-container" strech="true">

    <el-tab-pane label="登录" style="border-radius:15px;">
      <el-form :rules="loginRules" :model="loginForm"  class="loginForm" label-position="left" label-width="0px" v-loading="loading">
        <h3 class="login_title">登 录</h3>
        <el-form-item prop="key">
          <el-input type="text" v-model="loginForm.key" prefix-icon="el-icon-user" auto-complete="off" placeholder="用户名"></el-input>
        </el-form-item>
        <el-form-item prop="checkPass">
          <el-input type="password" v-model="loginForm.password" prefix-icon="el-icon-unlock" auto-complete="off" placeholder="密码"></el-input>
        </el-form-item>
        <el-form-item prop="checkCode">
          <el-row>
            <el-col :span="8">
              <el-input type="text" v-model="loginForm.vcode" auto-complete="off" style="width:160px;" prefix-icon="el-icon-key" placeholder="验证码">
              </el-input>

            </el-col>
            <el-col :span="2" :offset="7">
              <div class="divIdentifyCode" @click="getIdentifyCode">
                <img :src="imgCode" id="imgCode">
              </div>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item style="width: 100%">
          <el-button type="primary" style="width: 100%" @click="submitClick">登录</el-button>
        </el-form-item>
        <!-- 忘记密码 -->
        <el-button type="text" @click="forgetPassword">忘记密码</el-button>
        <el-dialog>
        </el-dialog>
      </el-form>
      <ForgetPass></ForgetPass>
    </el-tab-pane>

    <el-tab-pane label="注 册" style="border-radius:15px;">
      <Register></Register>
    </el-tab-pane>
  </el-tabs>
</template>



<script>
  import {validatePhone,validateMail,isEngNumLine} from "@/utils/validate";
  import Register from './Register.vue'
  import ForgetPass from './ForgetPass.vue'
  import {mapMutations} from 'vuex'
  import {isNotNullORBlank} from "../utils/utils";
  const TIME_COUNT = 60
  export default {

    data() {
      return {
        //登录
        loginRules: {
          account: [{required: false, message: '请输入用户名', trigger: 'blur'}],
          checkPass: [{required: false, message: '请输入密码', trigger: 'blur'}],
          checkCode: [{required: false,message: '请输入验证码',trigger: 'blur'}]
        },
        /*checked: true,*/
        loginForm: {
          key: '',
          password: '',
          vcode: ''
        },
        loading: this.$store.state.loading,
        imgCode: '',
        diaglogVisible : false,/**state.store**/
        vscode : '',

      }
    },
    created() {
      this.getIdentifyCode();

    },
    components:{
      Register,
      ForgetPass,

    },

    methods: {
     /* ...mapMutations(['','']),*/
      submitClick: function() {
        var _this = this;
        _this.$store.commit('changeLoading',true)
          this.postRequest('/user/password/login/operation', {
            key: this.loginForm.key, //this.loginForm.username,
            password: this.loginForm.password, // this.loginForm.password,
            vcode:this.loginForm.vcode
          }).then(resp => {
            _this.$store.commit('changeLoading', false);
            if (resp && resp.status == 200) {
              var data = resp.data;
              if(data.flag == true){
                console.log("正确")
                _this.$store.commit('login', data.obj);
                var path = _this.$route.query.redirect;

                _this.$router.replace({path: path == '/' || path == undefined ? '/home' : path});
              }else{
                this.$message.error(data.reason)
              }
            }else{
              this.$message.error('登录失败！');
            }
          });
        
      },

      /**
       * 忘记密码按钮
       * */
      forgetPassword:function(){
        store.commit('changeDiaglogVisible',true)
      },
      /**
       * 是否刷新，获取验证码图片
       */
      getIdentifyCode: function() {
        this.getRequest("/graph/vcode", "arraybuffer").then(response => {
            return 'data:image/png;base64,' + btoa(
            new Uint8Array(response.data).reduce((data, byte) => data + String.fromCharCode(byte), '')
          );
        }).then(data => {
          this.imgCode = data;
        }).catch(ex => {
          this.$message.error("服务器错误，获取验证码失败");
          //console.log(ex);
        })
      },
      initUserStore: function(userInfo) {},
      initRoutesStore: function(routes) {
        this.$store.state.routes = []
        for (let i of routes) {
          this.$store.state.routes.push({
            name: i.displayName,
            displayOrder: i.displayOrder,
            nodeId: i.nodeId,
            children: i.subSysFunList
          })
        }
      }
    }
  }
</script>

<style>
  .login-container {
    border-radius: 15px;
    background-clip: padding-box;
    margin: 150px auto;
    width: 370px;
    padding: 0px 0px 15px 0px;
    background: #fff;
    border: 1px solid #eaeaea;
    box-shadow: 0 0 25px #cac6c6;
  }
  .login_title {
    margin: 0px auto 40px auto;
    text-align: center;
    color: #505458;
  }
  .divIdentifyCode {
    margin-left: 0px;
    width: 100px;
    /*设置图片显示的宽*/
    height: 40px;
    /*图片显示的高*/
    background: #f1f1f1;
    text-align: center;
  }
  .loginForm {
    margin-left: 35px;
    margin-right: 35px;
  }
  .el-tabs__item {
    width: 186px;
    border-radius: 15px 15px 0 0;
  }
</style>

