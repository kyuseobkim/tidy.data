tidy.data
=========
**Function Description**

Below is the list of functions I wrote for the project

```R
run_analysis()
read_data(path, file.name)
fields_to_keep(fields)
human_readable_activity(y, activities)
produce_tidy_data(x, subject, activities, features)
```

`run_analysis` is the main function.

`read_data` takes care of reading the data from the file specified by `file.name` and located in `path`.

`field_to_keep` gives the features names that contain `mean()` or `std()`. This function helps us solve 2.

`human_readable_activity` converts activity number to human readable form. For instance,the function converts 1 to WALKING.

`produce_tidy_data` produces the tidy data specified by 6.
