<template>
  <div class="info">
    <div class="portrait"><img :src="portrait" width="80" height="80"></div>

    <div class="user-info">
      <div class="nick-level">
        <div class="nick" v-text="nick" />
        <div :class="'level level'+levelClass">
          <i :class="'icons icon_level_'+levelClass" />
          <span v-text="level" />
        </div>
      </div>

      <div class="uid" v-text="'工号:'+uid" />

      <div class="wealth">
        <div class="w-star"><span v-text="starNumber" /> <i class="icons star-sm" /></div>
        <span class="cut">|</span>
        <div class="w-diamond"><span v-text="diamondNumber" /> <i class="icons diamond-sm" /></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'UserInfo',
  props: ['nick', 'level', 'uid', 'starNumber', 'diamondNumber', 'portrait'],
  data() {
    return {}
  },
  computed: {
    levelClass() {
      const level = this.level
      if (level >= 1 && level <= 7) {
        return 1
      } else if (level >= 8 && level <= 16) {
        return 2
      } else if (level >= 16 && level <= 31) {
        return 3
      } else if (level >= 32 && level <= 63) {
        return 4
      } else if (level >= 64 && level <= 127) {
        return 5
      } else if (level >= 128 && level <= 254) {
        return 6
      } else {
        return 6
      }
    }
  }
}
</script>

<style scoped>
  .info {
    background: #fff;
    width: 300px;
    height: 180px;
    text-align: left;
  }

  .portrait {
    width: 80px;
    height: 80px;
    overflow: hidden;
    -webkit-border-radius: 40px;
    -moz-border-radius: 40px;
    -ms-border-radius: 40px;
    -o-border-radius: 40px;
    border-radius: 40px;
    background-color: #CCCCCC;
    margin: 40px 18px 0 15px;
  }

  .user-info {
    margin: 38px 0 0 0;
    vertical-align: top;
  }

  .portrait, .user-info, .w-star, .w-diamond, .nick, .level {
    display: inline-block;
  }

  .nick {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 110px;
  }

  .nick, .level {
    vertical-align: middle;
  }

  .cut {
    padding: 0 10px;
    color: #E9E9E9;
    font-size: 15px;
  }

  .uid, .wealth {
    margin-top: 14px;
  }

  .uid {
    font-size: 13px;
  }

  .nick-level {
  }

  .level {
    padding: 0 6px;
    color: #fff;
    font-size: 12px;
    margin-left: 5px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    -o-border-radius: 10px;
    border-radius: 10px;
    height: 20px;
    line-height: 20px;
  }

  .level .icons {
    display: inline-block;
  }

  .level1 {
    background: #50e4ce;
  }

  .level2 {
    background: #4a87f6;
  }

  .level3 {
    background: #fa9f47;
  }

  .level4 {
    background: #fad247;
  }

  .level5 {
    background: #5061e4;
  }

  .level6 {
    background: #ac47fa;
  }

  .level .num {
    display: inline-block;
  }

  .wealth {
    font-size: 12px;
    white-space: nowrap;
  }

  .wealth .icons {
    margin-top: -3px;
    vertical-align: middle;
  }
</style>
