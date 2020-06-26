<template>
<!--5 考勤统计：日考勤（迟到、早退、准时，每日出勤率）、月考勤（月迟到率、月早退率，月出勤率）、年考勤（）
-->
    <el-col>
        <el-row>
            <el-col :span="8">
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/attend/day" 
                    titletext="日考勤统计" 
                    :legdata="['日考勤统计']"  xname="" 
                    :xdata="['迟到','早退','准时','加班']" yname="人数/人"></bar-chart>
            </el-col>
            <el-col :span="8">
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/attend/month" 
                    titletext="月考勤统计" 
                    :legdata="['月考勤统计']"  xname="" 
                    :xdata="['迟到','早退','准时','加班']" yname="人数/人"></bar-chart>
            </el-col>
            <el-col :span="8">
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/attend/year"
                    titletext="年考勤统计" 
                    :legdata="['年考勤统计']"  xname="" 
                    :xdata="['迟到','早退','准时','加班']" yname="人数/人"></bar-chart>
            </el-col>
        </el-row>
    </el-col>
</template>
<script>
    import barChart from '../components/chart/BarChart'
    export default {
        components: {
            barChart
        },
        data() {
            return {
            }
        }
    }
</script>