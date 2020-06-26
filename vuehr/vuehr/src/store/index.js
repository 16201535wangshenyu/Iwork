import Vue from 'vue'
import Vuex from 'vuex'
import '../lib/sockjs'
import '../lib/stomp'
import {isNotNullORBlank} from "../utils/utils";

Vue.use(Vuex)

export default new Vuex.Store({
  //全局状态
  state: {

    user: {

      name: window.localStorage.getItem('user' || '[]') == null ? '未登录' : JSON.parse(window.localStorage.getItem('user' || '[]')).user.realName,
      userface: window.localStorage.getItem('user' || '[]')  == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).user.userFace,
      username: window.localStorage.getItem('user' || '[]')  == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).user.nickName,
      roles: window.localStorage.getItem('user' || '[]')  == null? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).roles
    },
    routes: [],
    msgList: [],
    isDotMap: new Map(),
    currentFriend: {},
    stomp: null,
    nfDot: false,
    diaglogVisible:false,
    loading: false
  },
  //改变全局状态
  mutations: {
    initMenu(state, menus){
      state.routes = menus;
    },
    login(state, user){

      state.user = user;
      if(window.localStorage.getItem('user' || '[]') == null)
          window.localStorage.setItem('user', JSON.stringify(user));
    },
    logout(state){
      window.localStorage.removeItem('user');
      state.routes = [];
    },
    toggleNFDot(state, newValue){
      state.nfDot = newValue;
    },
    updateMsgList(state, newMsgList){
      state.msgList = newMsgList;
    },
    updateCurrentFriend(state, newFriend){
      state.currentFriend = newFriend;
    },
    addValue2DotMap(state, key){
      state.isDotMap.set(key, "您有未读消息")
    },
    removeValueDotMap(state, key){
      state.isDotMap.delete(key);
    },
    //确认修改密码按钮
    ChangePassword:function(state) {

      state.diaglogVisible=false;
    },
    //取消修改密码按钮
    Cancel(state) {
      state.diaglogVisible = false;
    },
    changeDiaglogVisible(state,key){

      state.diaglogVisible=key;
    },
    changeLoading(state,key){
      state.loading=key;
    }
  },


//存放一些业务逻辑
  actions: {
    connect(context){
      context.state.stomp = Stomp.over(new SockJS("/ws/endpointChat"));
      context.state.stomp.connect({}, frame=> {
        console.log("连接成功！！！")
        var currentUser = JSON.parse(window.localStorage.getItem('user' || '[]')).user;
        const workId = currentUser.workId


        context.state.stomp.subscribe("/user/queue/chat", message=> {

          console.log("我从服务器端得到的消息如下")
          console.log(message.body)
          var msg = JSON.parse(message.body);
          var oldMsg = window.localStorage.getItem(msg.from + "#" + workId);

          if (oldMsg == null) {
            oldMsg = [];
            oldMsg.push(msg);
            window.localStorage.setItem(msg.from + "#" +workId, JSON.stringify(oldMsg))
          } else {
            var oldMsgJson = JSON.parse(oldMsg);
            oldMsgJson.push(msg);
            window.localStorage.setItem(msg.from + "#" +workId, JSON.stringify(oldMsgJson))

          }
          if (msg.from != context.state.currentFriend.workId) {
            context.commit("addValue2DotMap", "isDot#" +  msg.from + "#" +workId);
          }
          //更新msgList
          var oldMsg2 = window.localStorage.getItem(context.state.currentFriend.workId  + "#" + workId);
          var oldMsg3 = window.localStorage.getItem( workId + "#" +  context.state.currentFriend.workId);
          var oldJsonMsg1 = [];
          var oldJsonMsg2 = [];
          if (oldMsg2 != null) {
            oldJsonMsg1 = JSON.parse(oldMsg2);
          }
          if (oldMsg3 != null) {
            oldJsonMsg2 = JSON.parse(oldMsg3);
          }
          var tempMsg = []
          while (oldJsonMsg1.length && oldJsonMsg2.length) {
            console.log("oldJsonMsg1[]00============")
            console.log(oldJsonMsg1[0])
            console.log("oldJsonMsg1[]00============")
            if (oldJsonMsg1[0].timeStamp < oldJsonMsg2[0].timeStamp) {

              console.log("oldJsonMsg1[]more size==========")
              console.log(oldJsonMsg1[0].timeStamp)
              console.log("oldJsonMsg2[]more small==========")
              console.log(oldJsonMsg2[0].timeStamp)

              tempMsg.push(oldJsonMsg1.shift())
              // oldJsonMsg1.shift();
            } else {

              console.log(oldJsonMsg2[0].timeStamp)
              console.log("is else==========")
              console.log(oldJsonMsg1[0].timeStamp)
              tempMsg.push(oldJsonMsg2.shift())
              // oldJsonMsg2.shift()
            }
          }
          while (oldJsonMsg1.length) {
            tempMsg.push(oldJsonMsg1.shift())
            // oldJsonMsg1.shift();
          }
          while (oldJsonMsg2.length) {
            tempMsg.push(oldJsonMsg2.shift())
            // oldJsonMsg2.shift()
          }
          context.commit('updateMsgList', tempMsg)
          //
          // var oldMsg2 = window.localStorage.getItem(context.state.currentFriend.workId  + "#" + workId);
          // var oldMsg3 = window.localStorage.getItem( workId + "#" +  context.state.currentFriend.workId);
          // if (oldMsg2 == null) {
          //   console.log("11111111111111111111111111")
          //   context.commit('updateMsgList', oldMsg3);
          // } else if(oldMsg3 != null &&oldMsg2!=null ){
          //   console.log("222222222222222222")
          //   console.log("当前朋友的WorkId")
          //   console.log(context.state.currentFriend.workId)
          //   var oldMsgJson3 = JSON.parse(oldMsg3);
          //   var oldMsgJson2 = JSON.parse(oldMsg2);
          //   console.log(oldMsgJson2)
          //   console.log(oldMsgJson3)
          //   for(var j= 0;j< oldMsgJson3.length;j++){
          //     oldMsgJson2.push(oldMsgJson3[j])
          //   }
          //   console.log(oldMsgJson2)
          //   context.commit('updateMsgList', oldMsgJson2);
          // }else{
          //   console.log("33333333333333333333")
          //   context.commit('updateMsgList', JSON.parse(oldMsg2));
          // }
        });

        context.state.stomp.subscribe("/topic/nf", message=> {
          console.log("來了系統消息")
          context.commit('toggleNFDot', true);
        });
      }, failedMsg=> {
        console.log("连接失败！！！")

      });
    }
  }
});
