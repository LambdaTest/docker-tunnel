# Set Up Docker Tunnel for TestMu AI (Formerly LambdaTest)

<p align="center">
  <a href="https://www.testmuai.com/"><img src="https://img.shields.io/badge/MADE%20BY%20TestMu%20AI-000000.svg?style=for-the-badge&labelColor=000" alt="Made by TestMu AI"></a>
  <a href="https://hub.docker.com/"><img src="https://img.shields.io/docker/pulls/lambdatest/tunnel.svg?style=for-the-badge&labelColor=000000" alt="Docker pulls"></a>
  <a href="https://community.testmuai.com/"><img src="https://img.shields.io/badge/Join%20the%20community-blueviolet.svg?style=for-the-badge&labelColor=000000" alt="Community"></a>
</p>

## Getting Started

[TestMu AI](https://www.testmuai.com/) (Formerly LambdaTest) is the world's first full-stack AI Agentic Quality Engineering platform that empowers teams to test intelligently, smarter, and ship faster. Built for scale, it offers a full-stack testing cloud with 10K+ real devices and 3,000+ browsers. With AI-native test management, MCP servers, and agent-based automation, TestMu AI supports Selenium, Appium, Playwright, and all major frameworks.

With TestMu AI (Formerly LambdaTest), you can securely connect your local or private environments to the TestMu AI cloud using Docker Tunnel — the official Docker image for the TestMu AI (Formerly LambdaTest) tunnel binary.

- [Sign up on TestMu AI](https://www.testmuai.com/register/) (Formerly LambdaTest).
- Follow the [TestMu AI documentation](https://www.testmuai.com/support/docs/) (Formerly LambdaTest) for the full setup walkthrough.

### Prerequisites

- Docker installed on your machine
- Valid TestMu AI (Formerly LambdaTest) credentials (username and access key). Visit your [profile page](https://accounts.lambdatest.com/detail/profile) to fetch your credentials or [register here](https://accounts.lambdatest.com/register).

### Setup

Set your credentials as environment variables (where applicable).

**macOS / Linux:**

```bash
export LT_USERNAME="YOUR_USERNAME"
export LT_ACCESS_KEY="YOUR_ACCESS_KEY"
```

**Windows:**

```bash
set LT_USERNAME="YOUR_USERNAME"
set LT_ACCESS_KEY="YOUR_ACCESS_KEY"
```

### Usage

The entrypoint of the image is set to the tunnel binary with no extra arguments. Run the image without any arguments to see the help text.

This image supports all the tunnel modifier [flags available](https://www.lambdatest.com/support/docs/lambda-tunnel-modifiers/) in the tunnel command line binary, and passes them as-is to the entry point.

#### Version

```bash
docker run -it  lambdatest/tunnel:latest --version
```

#### Help

```bash
docker run -it  lambdatest/tunnel:latest --help
```

#### Basic

```bash
docker run -it --name lt lambdatest/tunnel:latest --user johndoe --key XXXXXXXXXXXX
```

#### Capturing logs in mounted volume on host machine

```bash
docker run -it  -v /mydir:/logs lambdatest/tunnel:latest --user joendoe --key XXXXXXXX --logFile /logs/tunnel.log
```

#### Using info api on tunnel to fetch tunnel status and stop tunnel

> Info API will be available on the host over port 13001. `curl -X GET http://127.0.0.1:13001/api/v1.0/info` can be used to probe the tunnel status and `curl -X DELETE http://127.0.0.1:13001/api/v1.0/stop` to stop tunnel.

```bash
docker run -it -p 13001:8000 lambdatest/tunnel:latest --user johndoe --key XXXXXXX  --infoAPIPort 8000
```

#### Using Proxy running on host machine at port 8082 having foo and bar as username and key

```bash
docker run -it lambdatest/tunnel:latest --user johndoe --key XXXXXXX  --proxy-host host.docker.internal --proxy-port 8082 --proxy-user foo --proxy-pass bar
```

#### Using Proxy running on another docker container within same default bridge network

> Assuming the container in which proxy is running has IP 172.17.0.2. The IP can be found from inside of the container or by inspecting the network to which container is attached.

```bash
docker run -it lambdatest/tunnel:latest --user johndoe --key XXXXXXX  --proxy-host 172.17.0.2  --proxy-port 8082 --proxy-user foo --proxy-pass bar
```

#### Using Proxy running on another docker container within same `custom` bridge network

> When you create a custom network, containers can reach each other using container names due to automatic service discovery. Assuming that `custom-network` already exists and a container named `proxy-service` has a proxy server running.

```bash
docker run -it lambdatest/tunnel:latest --user johndoe --key XXXXXXX  --proxy-host proxy-service  --proxy-port 8082 --proxy-user foo --proxy-pass bar
```

### Run tests

After the tunnel is running, configure your test scripts to use the tunnel and execute your tests.

View results on your TestMu AI dashboard.

## Development

- Clone the repo from [GitHub](https://github.com/LambdaTest/docker-tunnel)
- Run `docker build -t <build name> <cloned directory>`

## Considerations when testing web applications running on the host machine

By default the TestMu AI (Formerly LambdaTest) tunnel can no longer access webapps running on host machines or other docker containers using localhost or 127.0.0.1 when you run it using a docker container. This means that the test scripts need to be modified in the way they access the target webapp, according to the docker network topology and host operating system.

### Linux

On Linux, containers can run in a special network mode called `host`. This network mode makes the container use the host's network stack and does not create an isolated one for the containers. Running the following command makes the tunnel container run with host networking and can access the host's network. The test scripts can access services running on the host machine using localhost.

```bash
docker run -it  --network host lambdatest/tunnel:latest --user johndoe --key XXXXXXXXXXXX
```

### Mac and Windows

Unfortunately, on both Mac and Windows, host networking mode is not available due to the implementation of Docker Machine. The recommended approach to access services on the host machine is to use a special hostname `host.docker.internal` which resolves to the host machine. You can find more details on these links: [Mac](https://docs.docker.com/docker-for-mac/networking/), [Windows](https://docs.docker.com/docker-for-windows/networking/).

The test scripts need to use this special hostname in order to access the web services running on the host machine.

> The idiomatic way of testing on docker infra is to create a custom bridge network and access services using their container names. This method works on all operating systems.

## License

Licensed under the [MIT license](./LICENSE).

## Contributions

Contributions are welcome. Open an issue to discuss your idea before submitting a pull request. When reporting bugs, include your Docker version, OS, and tunnel version.

## TestMu AI (Formerly LambdaTest) Community

Connect with testers and developers in the [TestMu AI Community](https://community.testmuai.com/). Ask questions, share what you are building, and discuss best practices in test automation and DevOps.

## TestMu AI (Formerly LambdaTest) Certifications

Earn free [TestMu AI Certifications](https://www.testmuai.com/certifications/) for testers, developers, and QA engineers. Validate your skills in Selenium, Cypress, Playwright, Appium, Espresso and more. Industry-recognized, shareable on LinkedIn, and built by practitioners, not marketers.

## Learning Resources by TestMu AI (Formerly LambdaTest)

Learn modern testing through tutorials, guides, videos, and weekly updates:

* [TestMu AI Blog](https://www.testmuai.com/blog/)
* [TestMu AI Learning Hub](https://www.testmuai.com/learning-hub/)
* [TestMu AI on YouTube](https://www.youtube.com/@TestMuAI)
* [TestMu AI Newsletter](https://www.testmuai.com/newsletter/)

## LambdaTest is Now TestMu AI

On **January 12, 2026**, [LambdaTest evolved to TestMu AI](https://www.testmuai.com/lambdatest-is-now-testmuai/), the world's first fully autonomous **Agentic AI Quality Engineering Platform**.

Same team. Same infrastructure. Same customer accounts. All existing LambdaTest logins, scripts, capabilities, and integrations continue to work without change.

👉 Find the new home for [LambdaTest](https://www.testmuai.com).

### How LambdaTest Evolved into TestMu AI

In 2017, we launched LambdaTest with a simple mission: make testing fast, reliable, and accessible. As LambdaTest grew, we expanded into Test Intelligence, Visual Regression Testing, Accessibility Testing, API Testing, and Performance Testing, covering the full depth of the testing lifecycle.

As software development entered the AI era, testing had to evolve, too. We rebuilt the architecture to be AI-native from the ground up, with autonomous agents that **plan, author, execute, analyze, and optimize tests** while keeping humans in the loop. The platform integrates with your repos, CI, IDEs, and terminals, continuously learning from every code change and development signal.

That evolution earned a new name: **TestMu AI**, built for an AI-first future of quality engineering. TestMu is not a new name for us. It is the name of our annual community conference, which has brought together 100,000+ quality engineers to discuss how AI would reshape testing, long before that became an industry norm.

What started as a high-performance cloud testing platform has transformed into an AI-native, multi-agent system powering a connected, end-to-end quality layer. That evolution defined a new identity: LambdaTest evolved into TestMu AI, built for an AI-first future of quality engineering.

## Support

Got a question? Email [support@testmuai.com](mailto:support@testmuai.com) or chat with us 24x7 from our chat portal.
