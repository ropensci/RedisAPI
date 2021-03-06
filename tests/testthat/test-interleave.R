context("cmd_interleave")

test_that("cmd_interleave", {
  ## Basic cases:
  expect_that(cmd_interleave("a", "b"), equals(c("a", "b")))
  expect_that(cmd_interleave(c("a", "b"), c("c", "d")),
              equals(c("a", "c", "b", "d")))

  expect_that(cmd_interleave("a", list("b")), equals(list("a", "b")))
  expect_that(cmd_interleave(c("a", "b"), list("c", "d")),
              equals(list("a", "c", "b", "d")))
  expect_that(cmd_interleave(list("a", "b"), list("c", "d")),
              equals(list("a", "c", "b", "d")))

  ## Things with raw vectors:
  obj <- lapply(1:2, object_to_bin)
  expect_that(cmd_interleave(c("a", "b"), obj),
              equals(list("a", obj[[1]], "b", obj[[2]])))

  expect_that(cmd_interleave("a", obj[[1]]),
              equals(list("a", obj[[1]])))
  expect_that(cmd_interleave(obj[[1]], obj[[2]]),
              equals(obj))
  expect_that(cmd_interleave(obj[[1]], "b"),
              equals(list(obj[[1]], "b")))

  ## Corner cases:
  expect_that(cmd_interleave(c(), c()), equals(character(0)))
  expect_that(cmd_interleave(list(), list()), equals(list()))
  expect_that(cmd_interleave(NULL, NULL), equals(character(0)))

  ## Conversions:
  expect_that(cmd_interleave("a", 1L), equals(c("a", "1")))
  expect_that(cmd_interleave("a", 1.0), equals(c("a", "1")))
  expect_that(cmd_interleave("a", TRUE), equals(c("a", "1")))

  ## Error cases:
  expect_that(cmd_interleave("a", c()), throws_error("b must be length 1"))
  expect_that(cmd_interleave(c(), "b"), throws_error("b must be length 0"))
  expect_that(cmd_interleave("a", sin), throws_error("cannot coerce type"))
  expect_that(cmd_interleave(c("a", "b"), "c"),
              throws_error("b must be length 2"))

  ## Raw is stored more like character so that length(raw) is more
  ## like nchar(string).
  expect_that(cmd_interleave(runif(length(obj[[1]])), obj[[1]]),
              throws_error("b must be length"))
  expect_that(cmd_interleave(obj[[1]], runif(length(obj[[1]]))),
              throws_error("b must be length"))
})
