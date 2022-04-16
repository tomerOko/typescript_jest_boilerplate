
#!/bin/sh
# run from <...>/scripts
cd ../
sudo docker build -t run_ts_image . # build TODO: make the build conditional on flag --rebuild
sudo chown -R $USER:$(id -gn $USER) ./* # give permmisions in order to be able to adit the files
docker container rm -f run_ts_test_container # remove container if allready runing
docker run -itd --name run_ts_test_container -p 3006:3000 -v "$(pwd)"/:/app/ run_ts_image "npm i && tsc" # run the container (entrypoint in dockerfile)
sleep 1 # give the container a second to boot
docker container ls --filter name=run_ts_test_container # make sure the container is actualy runing
docker logs --follow run_ts_test_container # connect the shell to the container's logs outpout
