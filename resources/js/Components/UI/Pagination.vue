<template>
    <div class="flex gap-1">
        <template v-for="(link, index) in links">
            <span
                v-if="!link.url"
                class="py-2 px-4 rounded-md text-gray-500 border border-transparent"
                v-html="link.label"
            />
            <Link
                v-else
                :key="index"
                class="py-2 px-4 round-md"
                :href="link.url"
                :class="{
                    'bg-indigo-500 dark:bg-indigo-800 text-gray-300':
                        link.active,
                }"
                v-html="link.label"
            />
        </template>
    </div>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";

defineProps({
    links: Array,
});
</script>

<style lang="scss" scoped></style>
