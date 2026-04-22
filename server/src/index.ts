import { createYoga } from "graphql-yoga";
import { schema } from "./schema/index.ts";
import { buildContext } from "./context.ts";
import { env } from "./env.ts";

const yoga = createYoga({
  schema,
  context: buildContext,
  graphiql: true,
  maskedErrors: false,
  cors: {
    origin: "*",
    credentials: false,
    methods: ["GET", "POST", "OPTIONS"],
  },
  landingPage: false,
  graphqlEndpoint: "/graphql",
});

const server = Bun.serve({
  port: env.PORT,
  fetch: yoga,
});

console.log(`🚀 chores GraphQL @ http://localhost:${server.port}/graphql`);
