/** @type {import('vite').UserConfig} */
export default {
  base:
    process.env.NODE_ENV === "production"
      ? "https://cdn.nav.no/utvikling-admin/brillestotte-for-katter/prod"
      : undefined,
};
