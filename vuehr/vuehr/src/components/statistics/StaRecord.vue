<template>
<!--
    人事记录统计：人事调动图表4（各部门入职人数；离职人数；人员变动；合计）
-->
    <el-col>
        <!-- <el-table>
            表格统计
        </el-table> -->
        <el-row>
            <el-col :span="16">
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/PerRec/partBar"
                    titletext="人事调动柱状统计图"
                    :legdata="['人事调动柱状统计图']" xname="状态" 
                    :xdata="['入职人数','离职人数','人事变动']" yname="人数/人"></bar-chart>
            </el-col>
            <el-col :span="8">
                <nightingale-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/PerRec/percent"
                    titletext="人事调动统计图"
                    dataname="人事调动统计图"></nightingale-chart>
            </el-col>
        </el-row>
    </el-col>
</template>
<script>
    import nightingaleChart from '../components/chart/NightingaleChart'
    import barChart from '../components/chart/BarChart'
    export default {
        components: {
            nightingaleChart,
            barChart
        },
        data() {
            return {
            }
        }
    }
</script>