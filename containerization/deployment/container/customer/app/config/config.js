// define default config, but allow overrides from ENV vars
let config = {
    APP_DB_HOST: "REPLACE-DB-HOST",
    APP_DB_USER: "younganswer",
    APP_DB_PASSWORD: "younganswer",
    APP_DB_NAME: "COFFEE_SUPPLIER",
};

Object.keys(config).forEach((key) => {
    if (process.env[key] === undefined) {
        console.log(
            `[NOTICE] Value for key '${key}' not found in ENV, using default value.  See app/config/config.js`
        );
    } else {
        config[key] = process.env[key];
    }
});

module.exports = config;
