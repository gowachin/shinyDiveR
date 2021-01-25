cd ../
R CMD build shinyDiveR
mv shinyDiveR_* shinyDiveR/dev/docker/

R CMD build mn90
mv DiveR_* shinyDiveR/dev/docker/
