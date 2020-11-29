communication_data <-
  tibble(
    w1_comm_parent = rnorm(500,5,1),
    w1_comm_child = w1_comm_parent + rnorm(500, 0, 1),
    w2_comm_parent = ((w1_comm_parent + w1_comm_child)/2) + .5 ,
    w2_comm_child = ((w1_comm_parent + w1_comm_child)/2) +  1
  )

satisfaction_data <-
  (communication_data + rnorm(500, 1, .5) + 1) %>% 
  rename(
    w1_satis_parent = w1_comm_parent,
    w1_satis_child = w1_comm_child,
    w2_satis_parent = w2_comm_parent,
    w2_satis_child = w2_comm_child
  )

fam_data <- 
  communication_data %>% 
  bind_cols(satisfaction_data) %>% 
  mutate(family_id = row_number()) %>% 
  relocate(family_id)

fam_long_data <- fam_data %>% 
  pivot_longer(cols = (-family_id),
               names_to = c("wave","type","member"),
               names_sep = "_",
               values_to = "score")
