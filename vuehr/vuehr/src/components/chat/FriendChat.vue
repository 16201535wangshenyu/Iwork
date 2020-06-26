<template>
  <div>
    <el-container>
      <el-aside width="160px">
        <div class="friendListDiv" v-for="(hr,index) in hrs" :key="hr.userUid" @click="toggleFriend(hr)"
             v-bind:class="{currentChatFriend : currentFriend.userUid == hr.userUid}">

          <img :src="hr.userFace" class="userfaceImg"/>
          <el-badge :is-dot="isDotMap.has('isDot#'+hr.workId+'#'+currentUser.workId)">{{hr.realName}}</el-badge>
        </div>
        <div style="background-color: #20a0ff;height: 1px;width: 160px;"/>
      </el-aside>
      <el-main style="padding-top: 0px;padding-bottom: 0px">
        <div class="chatDiv" ref="chatDiv" id="chatDiv">
          <p v-show="currentFriend.realName">与
            <el-tag type="primary" size="small" style="margin-left: 5px;margin-right: 5px">{{currentFriend.realName}}
            </el-tag>
            聊天中
          </p>
          <template v-for="msg in msgList">
            <!--发送来的消息-->
            <div
              style="display: flex;justify-content: flex-start;align-items: center;box-sizing: border-box;"
              v-if="msg.from == currentFriend.workId">
              <img :src="currentFriend.userFace" class="userfaceImg">
              <div
                style="display: inline-flex;border-style: solid;border-width: 1px;border-color: #20a0ff;border-radius: 5px;padding: 5px 8px 5px 8px">
                {{msg.msg}}
              </div>
            </div>
            <!--发出去的消息-->
            <div v-if="msg.from!=currentFriend.workId"
                 style="display: flex;justify-content: flex-end;align-items: center;box-sizing: border-box;">
              <div
                style="display: inline-flex;border-style: solid;border-width: 1px;border-color: #20a0ff;border-radius: 5px;padding: 5px 8px 5px 8px;margin-right: 3px;background-color: #9eea6a">
                {{msg.msg}}
              </div>
              <img :src="currentUser.userFace" class="userfaceImg">
            </div>
          </template>
        </div>
        <div style="text-align: left;margin-top: 10px">
          <el-input v-model="msg" placeholder="请输入内容" size="mini" style="width: 600px;" type="textarea"
                    autosize></el-input>
          <el-button :disabled="!currentFriend.userUid" size="small" type="primary" class="sendBtn" @click="sendMsg"><i
            class="fa fa-send"
            style="margin-right: 15px"></i>发送
          </el-button>
        </div>
      </el-main>
    </el-container>
  </div>
</template>
<script>
  export default{
    data(){
      return {
        hrs: [],
        msg: '',
        currentUser: {},
        currentFriend: {}
      }
    },
    computed: {
      msgList: {
        get: function () {
          return this.$store.state.msgList
        }
      },
      isDotMap: {
        get: function () {
          return this.$store.state.isDotMap
        }
      }
    },
    watch: {
      msgList(){
        document.getElementById('chatDiv').scrollTop = document.getElementById('chatDiv').scrollHeight;
      }
    },
    methods: {
      sendMsg(){
        var _this = this;
        let timestamp = new Date().getTime();
        var oldMsg = window.localStorage.getItem(_this.currentUser.workId + "#" + this.currentFriend.workId);
        if (oldMsg == null) {
          oldMsg = [];
          oldMsg.push({msg: this.msg, from: _this.currentUser.workId, timeStamp: timestamp});
          console.log("我存放的键")
          console.log(_this.currentUser.workId + "#" + this.currentFriend.workId)
          window.localStorage.setItem( _this.currentUser.workId + "#" + this.currentFriend.workId, JSON.stringify(oldMsg))
        } else {
          var oldMsgJson = JSON.parse(oldMsg);
          oldMsgJson.push({msg: this.msg, from:  _this.currentUser.workId, timeStamp: timestamp});
          console.log("我存放的键")
          console.log( _this.currentUser.workId + "#" + this.currentFriend.workId)
          window.localStorage.setItem( _this.currentUser.workId + "#" + this.currentFriend.workId, JSON.stringify(oldMsgJson))
        }
        this.$store.state.stomp.send("/ws/chat", {}, this.msg + ";" + this.currentFriend.workId + "-" + timestamp);
        this.msg = '';
        this.updateChatDiv();
      },
      updateChatDiv(){
        var _this = this;
        var oldMsg = window.localStorage.getItem(this.currentUser.workId + "#" + this.currentFriend.workId);
        var oldMsg2 = window.localStorage.getItem(this.currentFriend.workId + "#" + this.currentUser.workId);

        console.log("_this.msgList")
        console.log(_this.msgList)

        console.log("oldMsg1")
        console.log(oldMsg)
        console.log("oldMsg2")
        console.log(oldMsg2)

        var oldJsonMsg1 = [];
        var oldJsonMsg2 = [];
        if (oldMsg != null) {
          oldJsonMsg1 = JSON.parse(oldMsg);
        }
        if (oldMsg2 != null) {
          oldJsonMsg2 = JSON.parse(oldMsg2);
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
        _this.$store.commit('updateMsgList', tempMsg)
        //
        // if (oldMsg == null && oldMsg2== null) {
        //   this.$store.commit('updateMsgList', [])
        //
        // } else if(oldMsg !=null && oldMsg2 == null){
        //   var oldMsgJson = JSON.parse(oldMsg);
        //   _this.$store.commit('updateMsgList', oldMsgJson)
        // }else if(oldMsg2!=null && oldMsg !=null){
        //   var tempMsg = []
        //   var oldJsonMsg1 = JSON.parse(oldMsg);
        //   var oldJsonMsg2 = JSON.parse(oldMsg2);
        //   while (oldJsonMsg1.length && oldJsonMsg2.length) {
        //
        //     if (oldJsonMsg1[0].timestamp < oldJsonMsg2[0].timestamp) {
        //       tempMsg.push(oldJsonMsg1.shift())
        //       // oldJsonMsg1.shift();
        //     } else {
        //       tempMsg.push(oldJsonMsg2.shift())
        //       // oldJsonMsg2.shift()
        //     }
        //   }
        //
        //   while (oldJsonMsg1.length) {
        //     tempMsg.push(oldJsonMsg1[0].timestamp)
        //     oldJsonMsg1.shift();
        //   }
        //   while (oldJsonMsg2.length) {
        //     tempMsg.push(oldJsonMsg2[0].timestamp)
        //     oldJsonMsg2.shift()
        //   }
        //   _this.$store.commit('updateMsgList', tempMsg)
        //
        // }else if(oldMsg == null && oldMsg2!=null){
        //   var oldMsgJson = JSON.parse(oldMsg2);
        //   _this.$store.commit('updateMsgList', oldMsgJson)
        // }

        // if (oldMsg == null && oldMsg2== null) {
        //   this.$store.commit('updateMsgList', [])
        //
        // } else if(oldMsg !=null && oldMsg2 == null){
        //   var oldMsgJson = JSON.parse(oldMsg);
        //   _this.$store.commit('updateMsgList', oldMsgJson)
        // }else if(oldMsg2!=null && oldMsg !=null){
        //
        //   var oldMsgJson1 = JSON.parse(oldMsg);
        //   var oldMsgJson2 = JSON.parse(oldMsg2);
        //   for(var j= 0;j<oldMsgJson1.length;j++){
        //     oldMsgJson2.push(oldMsgJson1[j])
        //   }
        //   _this.$store.commit('updateMsgList', oldMsgJson2)
        // }else if(oldMsg == null && oldMsg2!=null){
        //   var oldMsgJson = JSON.parse(oldMsg2);
        //   _this.$store.commit('updateMsgList', oldMsgJson)
        // }
      },
      toggleFriend(hr){
        //切换数据
        if (hr == this.currentFriend) {
          return;
        }
        this.currentFriend = hr;
        this.$store.commit('updateCurrentFriend', hr);

        this.updateChatDiv();
        this.$store.commit("removeValueDotMap", "isDot#" + this.currentUser.workId + "#" + hr.workId);
        document.getElementById('chatDiv').scrollTop = document.getElementById('chatDiv').scrollHeight;
      },
      loadHrs(){
        var _this = this;
        this.getRequest("/chat/hrs").then(resp=> {
          _this.hrs = resp.data;
        })
      }
    },
    mounted: function () {
      this.loadHrs();
      this.currentUser = JSON.parse(window.localStorage.getItem('user' || '[]')).user;
    }
  }
</script>
<style>
  .userfaceImg {
    width: 37px;
    height: 37px;
    border-radius: 30px;
    margin-right: 10px;
  }

  .friendListDiv {
    display: flex;
    justify-content: flex-start;
    padding-left: 20px;
    box-sizing: border-box;
    align-items: center;
    width: 160px;
    height: 40px;
    border-color: #20a0ff;
    border-left-style: solid;
    border-top-style: solid;
    border-right-style: solid;
    border-width: 1px;
    cursor: pointer
  }

  .chatDiv {
    border-color: #20a0ff;
    border-style: solid;
    border-radius: 5px;
    border-width: 1px;
    box-sizing: border-box;
    width: 700px;
    height: 450px;
    overflow-y: auto;
    padding-bottom: 50px;
  }

  .sendBtn {
    padding-left: 25px;
    padding-right: 25px
  }

  .currentChatFriend {
    background-color: #dcdfe6;
  }
</style>
