<template>
    <span class="">{{ formattedPrice }}</span>
</template>

<script setup>
import { computed } from "vue";

const props = defineProps({
    price: [Number, String],
});

const formattedPrice = computed(() =>
    Number(props.price).toLocaleString("en-US", {
        style: "currency",
        currency: "USD",
        maximumFractionDigits: 0,
    }),
);
</script>

<style lang="scss" scoped></style>
