context("Redis commands")

test_that("Redis commands", {
  expect_is(redis, "redis_commands")
  expect_error(redis$new <- 1, "locked environment")
  expect_identical(redis$PING(), list("PING"))
})

test_that("Filter", {
  tmp <- redis_cmds(identity)
  expect_less_than(length(filter_redis_commands(tmp, "1.0.0")),
                   length(tmp))
  expect_equal(length(filter_redis_commands(tmp, "0.9.9")), 0)

  mv <- unname(max(cmd_since))
  expect_equal(length(filter_redis_commands(tmp, mv)),
               length(tmp))
  expect_equal(length(filter_redis_commands(tmp, as.character(mv))),
               length(tmp))

  expect_error(filter_redis_commands(tmp, TRUE),
               "No redis connection to get version from")
})

test_that("subscribe", {
  expect_error(redis$SUBSCRIBE("foo"),
               "Do not use SUBSCRIBE")
  expect_error(redis$SUBSCRIBE(),
               "Do not use SUBSCRIBE")
})
