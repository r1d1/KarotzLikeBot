#/usr/bin/python

import argparse
import json
import time
import os
import requests
# This script is made to fetch automatically files from thingiverse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch required models from thingiverse")

    parser.add_argument("--output", "-o", help="output folder", default="./")
    parser.add_argument("--file", "-n", help="source file for models", default=None)
    args = parser.parse_args()
    
    print(args)

    things_data = json.load(open(args.file,'r'))
    for th in things_data['files_thingiverse']:
        thing_name = th['name']
        file_id = th['url'].replace('https://www.thingiverse.com/thing:', '')
        #link = th['url'].replace('thing:','download:')
        link = os.path.join(th['url'], 'zip')
        __, ext = os.path.splitext(link)
        print(link)
        output_file = "{}{}.zip".format(thing_name, ext.lower())
        print(output_file)
        #if organize:
        #    output_file = os.path.join(str(thing_id), output_file)
        output_file = os.path.join(args.output, output_file)
        
        # generate proper link
        #base_url = "https://www.thingiverse.com/{}:{}"
        #url = base_url.format("download", file_id)
        #r = requests.head(url)
        #link = r.headers.get("Location", None)

        # Actual download request:
        sleep_time = 1.0;
        r = None;

        while r is None or r.status_code != 200:
            print("Downloading {}".format(output_file));
            r = requests.get(link, stream=True);
            if r.status_code == 200:
                with open(output_file, 'wb') as fout:
                    for chunk in r.iter_content(chunk_size=1024):
                        if chunk:
                            fout.write(chunk);
            else:
                time.sleep(sleep_time);
                sleep_time += 2.0;
                if sleep_time > 600:
                    print("cannot download {}".format(link));
                    break;
        time.sleep(0.5)
