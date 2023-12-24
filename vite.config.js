import { sveltekit } from '@sveltejs/kit/vite';


/** @type {import('vite').UserConfig} */
const config = {
	plugins: [sveltekit()],
	server: {
		hmr: {
			clientPort: 443,
			host: "443-richardiand-fullstackwe-f0uq51p0um9.ws-us107.gitpod.io"
		}
	}
};

export default config;
