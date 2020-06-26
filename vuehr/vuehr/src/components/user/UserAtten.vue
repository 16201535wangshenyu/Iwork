<template>
  <div class="clearfix wrap">
    <div class="top clearfix">
      <UserInfo
        class="float-left"
        :nick="userInfo.nick||''"
        :portrait="userInfo.portrait || ''"
        :level="userInfo.ulevel || 1"
        :uid="userInfo.uid || ''"
        :star-number="userInfo.point||0"
        :diamond-number="userInfo.gold||0"
      />
      <UserMenu
        class="float-left"
        :uid="userInfo.uid"/>
    </div>
    <div style="text-align: center;">
      <UserContent style="text-align: left;"></UserContent>
    </div>
  </div>
</template>

<script>
  import UserInfo from './UserAtten/UserInfo'
  import UserContent from './UserAtten/UserContent'
  import UserMenu from './UserAtten/UserMenu'

  export default {
    name: "UserAtten",
    components: {
      UserMenu,
      UserContent,
      UserInfo
    },
    data() {
      return {
        isLogin: false,
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
        userInfo: {}
      }
    },
    mounted()  {
      var _this = this;
        if(JSON.parse(window.localStorage.getItem('user' || '[]')).user == null)
          return ;
        this.user =JSON.parse(window.localStorage.getItem('user' || '[]')).user
        this.userInfo = {
          nick: _this.user.realName,
          ulevel: _this.user.workAge,
          uid: _this.user.workId,
          gold: _this.user.oweDepartment.name,
          point: _this.user.position.name,
          portrait: _this.user.userFace

      }
    }
  }
</script>

<style scoped>
  .top{padding: 0 170px; margin: 0 auto; }
  .clearfix:after {
    content: "";
    display: table;
    clear: both;
  }
  .float-left {
    float: left;
  }
  .wrap {
    text-align: left;
  }
</style>
