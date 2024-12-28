const express = require("express");
const fetch = require("node-fetch");
const bodyParser = require("body-parser");
const cors = require("cors");
const supplier = require("./app/controller/supplier.controller");
const app = express();
const mustacheExpress = require("mustache-express");
const favicon = require("serve-favicon");
const https = require("https");
// parse requests of content-type: application/json
app.use(bodyParser.json());
// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.options("*", cors());
app.engine("html", mustacheExpress());
app.set("view engine", "html");
app.set("views", __dirname + "/views");
app.use(express.static("public"));
app.use(favicon(__dirname + "/public/img/favicon.ico"));

function fetchIpInfo() {
	return new Promise((resolve, reject) => {
		const options = {
			path: "/json/",
			host: "ipapi.co",
			port: 443,
			headers: { "User-Agent": "nodejs-ipapi-v1.02" },
		};

		https
			.get(options, (resp) => {
				let body = "";
				resp.on("data", (data) => {
					body += data;
				});

				resp.on("end", () => {
					try {
						const loc = JSON.parse(body);
						const result = {
							ip: loc.ip,
							country: loc.country_name,
							region: loc.region,
							lat_long: `${loc.latitude}, ${loc.longitude}`,
							timezone: loc.timezone,
						};
						resolve(result);
					} catch (error) {
						reject(error);
					}
				});
			})
			.on("error", (error) => {
				reject(error);
			});
	});
}

// list all the suppliers
app.get("/", async (req, res) => {
	const config = { host: req.get("host").split(":").shift() };

	try {
		const task = await (
			await fetch(`${process.env.ECS_CONTAINER_METADATA_URI_V4}/task`)
		).json();

		config.launch_type = task.LaunchType;
		config.cluster = task.Cluster;
		config.task_arn = task.TaskARN.split("/").pop();
		config.container_arn = task.Containers[0].ContainerARN.split("/").pop();
		config.container_image = task.Containers[0].Image.split("@").shift();
	} catch (error) {
		console.error(error);
	}

	try {
		const ipInfo = await fetchIpInfo();
		config.public_ip = ipInfo.ip;
		config.geo_country_name = ipInfo.country;
		config.geo_region_name = ipInfo.region;
		config.geo_lat_long = ipInfo.lat_long;
		config.geo_timezone = ipInfo.timezone;
	} catch (error) {
		console.error(error);
	}

	res.render("index", config);
});

// health check
app.get("/health", (req, res) => {
	res.render("health", {});
});

app.get("/suppliers", supplier.findAll);

// handle 404
app.use(function (req, res, next) {
	res.status(404).render("404", {});
});

// set port, listen for requests
const app_port = process.env.APP_PORT || 80;
app.listen(app_port, () => {
	console.log(`Server is running on port ${app_port}.`);
});
