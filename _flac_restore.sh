channels_per_file=8;for file in *.flac;do
 ( for chan in $(seq 1 $channels_per_file);do echo sox $file $file"_channel_"$chan".flac" remix $chan;
                                                 sox $file $file"_channel_"$chan".flac" remix $chan;done;
                                                 
echo reconverting ; echo sox -M $(for chan in $(seq 1 $channels_per_file);do echo $file"_channel_"$chan".flac";done ) "fixed_"$file 
                         sox -M $(for chan in $(seq 1 $channels_per_file);do echo $file"_channel_"$chan".flac";done ) "fixed_"$file ) &
                         done;wait
                         
