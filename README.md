# flvoters-loader
Utility scripts used to publish the Florida Voter Registration extract on DoltHub

Further information on the file layout, and how to request an extract can be found here: https://dos.myflorida.com/elections/data-statistics/voter-registration-statistics/voter-extract-disk-request/

Assuming the extract disk is mounted at ```/mnt/flvoters```, the commands to load the voter detail dataset are:

```
dolt clone wilj/flvoters
./load_voter_detail_disk.sh /mnt/flvoters
```

