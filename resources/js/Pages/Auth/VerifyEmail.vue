<template>
    <div>You need to be verified first to see this page!</div>
    <div>
        <Link
            :href="route('verification.send')"
            as="button"
            method="POST"
            class="text-indigo-600 dark:text-indigo-400"
        >
            Resend verification email
        </Link>
    </div>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";
</script>

<style lang="scss" scoped></style>
