import js from "@eslint/js";
import pluginVue from "eslint-plugin-vue";

export default [
    // Εφαρμογή των προτεινόμενων ρυθμίσεων JS
    js.configs.recommended,
    // Εφαρμογή των ρυθμίσεων για Vue 3
    ...pluginVue.configs["flat/recommended"],

    {
        files: ["**/*.js", "**/*.vue"],
        languageOptions: {
            ecmaVersion: 2020,
            sourceType: "module",
            globals: {
                browser: true,
                amd: true,
                node: true,
            },
        },
        rules: {
            indent: ["error", 2],
            quotes: ["warn", "single"],
            semi: ["warn", "never"],
            "no-unused-vars": [
                "error",
                { vars: "all", args: "after-used", ignoreRestSiblings: true },
            ],
            "comma-dangle": ["warn", "always-multiline"],
            "vue/multi-word-component-names": "off",
            "vue/max-attributes-per-line": "off",
            "vue/no-v-html": "off",
            "vue/require-default-prop": "off",
            "vue/singleline-html-element-content-newline": "off",
            "vue/html-self-closing": [
                "warn",
                {
                    html: {
                        void: "always",
                        normal: "always",
                        component: "always",
                    },
                },
            ],
            "vue/no-v-text-v-html-on-component": "off",
        },
    },
];
