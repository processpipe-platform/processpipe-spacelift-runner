# Repository Guidelines

## Project Structure & Module Organization
The root of this repo centers on the `Dockerfile` that builds the ProcessPipe Spacelift runner image, alongside `README.md` and `LICENSE`. Add helper shell or Python utilities in `scripts/`, and keep container bootstrap assets such as templates or preseed files in `assets/`. When you introduce validation scripts, place them beneath `tests/` with folders per tool to keep smoke checks isolated.

## Build, Test, and Development Commands
`docker build -t processpipe-spacelift-runner:local .` produces the image with your local changes. Use `docker run --rm -it processpipe-spacelift-runner:local bash` to confirm that required binaries and credentials provisioning behave as expected. Run `docker build --progress=plain --no-cache -t processpipe-spacelift-runner:clean .` before publishing to ensure the layers install cleanly from scratch.

## Coding Style & Naming Conventions
Author Docker instructions in uppercase and combine package installs in a single `RUN` block with `apt-get update && apt-get install ... && rm -rf /var/lib/apt/lists/*` to keep the image slim. Within multiline shell blocks, indent continued commands by two spaces and prefer `set -euxo pipefail`. Name helper scripts using `snake_case.sh` and document entrypoints with a short comment header.

## Testing Guidelines
We rely on container smoke tests: add executable scripts under `tests/` named `test_<tool>.sh` that exit non-zero on failure. Execute them via `docker run --rm processpipe-spacelift-runner:local ./tests/test_<tool>.sh`. For new tooling, capture version output during the test to prove the binary is available.

## Commit & Pull Request Guidelines
History currently consists of the initial bootstrap commit; continue with concise, imperative subject lines such as `image: install terraform 1.6.5`. Reference Jira issues or Spacelift stack IDs in the body when relevant, and describe any image size deltas. Pull requests should include: purpose summary, list of new tools or version bumps, manual test log (e.g., command output snippet), and any configuration follow-ups.

## Security & Configuration Tips
Pin package versions or checksums whenever possible and prefer archival URLs over latest tags. Never bake secrets into the image; rely on Spacelift environment variables or mounts. Validate that Azure/AWS CLIs are configured to read credentials at runtime rather than build time.
