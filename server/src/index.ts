import { createYoga } from "graphql-yoga";
import { GraphQLError } from "graphql";
import { schema } from "./schema/index.ts";
import { buildContext } from "./context.ts";
import { env } from "./env.ts";

const yoga = createYoga({
  schema,
  context: buildContext,
  graphiql: true,
  cors: {
    origin: "*",
    credentials: false,
    methods: ["GET", "POST", "OPTIONS"],
  },
  landingPage: false,
  graphqlEndpoint: "/graphql",
  // Resolvers throw plain `Error` for user-facing problems (e.g. "On
  // cooldown — try again in 5 minutes"). Yoga's default masking would
  // turn those into "Unexpected error", hiding the cause from the kid.
  // Forward the original message to the client.
  maskedErrors: {
    maskError(error, message) {
      if (error instanceof GraphQLError) return error;
      if (error instanceof Error) {
        return new GraphQLError(error.message, {
          originalError: error,
        });
      }
      return new GraphQLError(message);
    },
  },
});

const server = Bun.serve({
  port: env.PORT,
  fetch: yoga,
});

console.log(`🚀 chores GraphQL @ http://localhost:${server.port}/graphql`);
