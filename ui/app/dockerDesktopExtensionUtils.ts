import { createDockerDesktopClient } from "@docker/extension-api-client";

export const ddClient = createDockerDesktopClient();

export function openInBrowser(url: string): void {
    ddClient.host.openExternal(url);
}
