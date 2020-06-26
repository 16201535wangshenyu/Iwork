<template>
<!--
    人事信息统计：
    各个部门内级别的人数统计（'正高级','副高级','中级','初级','员级'）部门名称和人数统计
-->
    <el-col>
        <el-row>
            <el-col :span="24">
                <!-- /statistics/EmpInfo/jobLevelInfo -->
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/PerInfo/level"
                    titletext="各部门级别人数统计"
                    :legdata="['正高级','副高级','中级','初级','员级','平均值']" xname="部门名称" 
                    :xdata="['股东会','董事会','总办','财务部','市场部','华北市场部',
                    '华南市场部','西北市场部','西安市场','技术部',
                    '运维部']" yname="人数/人"></bar-chart>
            </el-col>
        </el-row>
    </el-col>
</template>
<script>
    import lineChart from '../components/chart/LineChart'
    import nightingaleChart from '../components/chart/NightingaleChart'
    import barChart from '../components/chart/BarChart'
    export default {
        components: {
            lineChart,
            nightingaleChart,
            barChart
        },
        data() {
            return {
            }
        }
    }
</script>