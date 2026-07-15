// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'Unified Modelling Schema',
			description: 'A portable, semantic schema for relational, graph, document, and multi-model data.',
			social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/FactEngineAI/UnifiedModellingSchema' }],
			sidebar: [
				{
					label: 'Guide',
					items: [{ autogenerate: { directory: 'guides' } }],
				},
				{
					label: 'Reference',
					items: [{ autogenerate: { directory: 'reference' } }],
				},
			],
		}),
	],
});
