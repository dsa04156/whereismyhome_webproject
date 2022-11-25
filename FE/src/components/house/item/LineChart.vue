<template>
    <LineChartGenerator
        :chart-options="chartOptions"
        :chart-data="chartData"
        :chart-id="chartId"
        :dataset-id-key="datasetIdKey"
        :plugins="plugins"
        :css-classes="cssClasses"
        :styles="styles"
        :width="width"
        :height="height"
    />
</template>

<script>
import { Line as LineChartGenerator } from 'vue-chartjs/legacy';

import { Chart as ChartJS, Title, Tooltip, Legend, LineElement, LinearScale, CategoryScale, PointElement } from 'chart.js';

ChartJS.register(Title, Tooltip, Legend, LineElement, LinearScale, CategoryScale, PointElement);

export default {
    name: 'LineChart',
    components: {
        LineChartGenerator,
    },
    props: {
        dealYear: {
            type: Array,
        },
        avgAmount: {
            type: Array,
        },
        chartId: {
            type: String,
            default: 'line-chart',
        },
        datasetIdKey: {
            type: String,
            default: 'label',
        },
        width: {
            type: Number,
            default: 400,
        },
        height: {
            type: Number,
            default: 350,
        },
        cssClasses: {
            default: '',
            type: String,
        },
        styles: {
            type: Object,
            default: () => {},
        },
        plugins: {
            type: Array,
            default: () => [],
        },
    },
    data() {
        return {
            chartData: {
                labels: this.dealYear,
                datasets: [
                    {
                        label: '평균 매매가(만원)',
                        backgroundColor: '#f87979',
                        data: this.avgAmount,
                    },
                ],
            },
            chartOptions: {
                responsive: true,
                maintainAspectRatio: false,
            },
        };
    },
};
</script>
