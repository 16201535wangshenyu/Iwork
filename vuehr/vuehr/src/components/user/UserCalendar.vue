<template>
  <div class="hello">
    <el-form>
      <el-form-item>
        <el-row style="">
          <el-col :span="8" >
            <div style=""></div>
          </el-col>
          <el-col :span="10" :offset="7">
            <el-date-picker label="" size='small' v-model="selectDate" type="month" placeholder="选择月" value-format="yyyy-MM">
            </el-date-picker>
            <el-button type='primary' size="small" @click='changeDate' style="">确定</el-button>
            
            <el-button class="clearcal" type='danger' size="small" @click='destoryDate' plain>清空日程</el-button>
          </el-col>
        </el-row>
      </el-form-item>
    </el-form>
    <full-calendar  :config="config" :events="events" ref="calendar" @event-selected='eventClick' @day-click="dayClick">
    </full-calendar>
    <add-schedule v-if="isAdd" :isAdd='isAdd' :editItem='editItem' :events="events"  @add='addItem' @close='isAdd = false'></add-schedule>
  </div>
</template>
<script>
  // npm install --save  moment jquery vue-full-calendar
  import {
    FullCalendar
  } from 'vue-full-calendar'
  import "fullcalendar/dist/fullcalendar.css";
  import addSchedule from '@/components/components/calendar/add.vue'
  export default {
    data() {
      return {
        isAdd: false,
        selectDate: '', //日期选择器选中的月份
        config: {
          firstDay: '0', //以周日为每周的第一天
          // weekends: true,//是否在日历中显示周末
          locale: 'zh-cn', //语言
          defaultView: 'month', //默认按月显示
          height: 'auto', //高度
          fixedWeekCount: false, //是否固定显示六周
          weekMode:"liquid",//周数不定，每周的高度可变，整个日历高度不变
          allDaySlot: false,
          // allDay:true,
          buttonText:{
            today:"今天"
          },
          header: { //表头信息
            left: 'hide, custom',
            center: 'prevYear,prev, title, next,nextYear',
            right: 'today',
          },
        },
        events: [],
        newItem: {},
        editItem: {}
      }
    },
    components: {
      FullCalendar,
      addSchedule
    },
    created() {
      this.loadEvents();
    },
    methods: {
      changeDate() {
        // this.$refs.calendar.fireMethod('gotoDate', this.selectDate)
        console.log("aaa")
        this.$refs.calendar.fireMethod('gotoDate',this.selectDate);
      },
      eventClick(event) { //events的点击事件
        this.editItem = event
        this.isAdd = true
      },
      dayClick(date, jsEvent, view) { //日期的点击事件
        this.editItem = {}
        this.isAdd = true
      },
      loadEvents() {
        let events = JSON.parse(localStorage.getItem("ents") || '[]')
        this.events = events
      },
      destoryDate:function(){
        this.$confirm('此操作将永久删除全部日程, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.events=['']
          localStorage.setItem('ents', JSON.stringify(this.events));
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });          
        });
      },
      
      addItem(detail) {
        this.newItem = JSON.parse(detail)
        if (this.editItem.id) { //如果是编辑，就删掉该条
          this.events.forEach((el, ind) => {
            if (el.id == this.editItem.id) {
              this.events.splice(ind, 1)
            }
          });
        }
        let con = {
          id: this.editItem.id ? this.editItem.id : this.setUuid(),
          title: this.newItem.title,
          start: this.newItem.period[0],
          end: this.newItem.period[1],
        }
        this.events.push(con);
        let list = JSON.parse(localStorage.getItem('ents') || '[]')
        list.unshift(con);
        localStorage.setItem('ents', JSON.stringify(list));
      },
      setUuid() {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
          s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4";
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);
        s[8] = s[13] = s[18] = s[23];
        var uuid = s.join("");
        return uuid;
      },
    },
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
<style src="../../../static/vue-f-calendar.css"></style>
