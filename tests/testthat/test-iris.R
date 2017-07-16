context("iris")

test_that("iris r_to_py", {
  iris_csv <- tempfile("iris", fileext = "csv")

  readr::write_csv(iris, iris_csv)

  pandas <- reticulate::import("pandas")
  py_iris <- pandas$read_csv(iris_csv)

  iris$Species <- as.character(iris$Species)
  expect_null(
    pandas$util$testing$assert_frame_equal(
      py_iris,
      as_pandas(iris)
    )
  )
})


test_that("iris py_to_r", {
  iris_csv <- tempfile("iris", fileext = "csv")

  readr::write_csv(iris, iris_csv)

  pandas <- reticulate::import("pandas")
  py_iris <- pandas$read_csv(iris_csv, encoding = "utf8")

  iris$Species <- as.character(iris$Species)
  expect_true(all.equal(dplyr::tbl_df(iris), as.data.frame(py_iris)))
})

