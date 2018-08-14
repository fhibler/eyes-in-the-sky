# eyes-in-the-sky

Instructions and Dockerfiles for tracking flights with your Raspberry Pi and a USB TV stick.

Inspired by Alex Ellis' blog post: [Get eyes in the sky with your Raspberry Pi](https://blog.alexellis.io/track-flights-with-rpi/)

This repo contains the following:

* dump1090 - A docker container for [MalcolmRobb/dump1090](https://github.com/malcolmrobb/dump1090) that is a simple Mode S decoder for [RTLSDR devices](http://flightaware.com/adsb/prostick/).
* flightaware - A docker container for FlightAware.com's [PiAware](http://flightaware.com/adsb/piaware/) feeder app.
* docker-compose.yml - A docker compose file where all configuration is made.

## Simple setup

1. Make sure Docker is installed on your raspberry pi:

    ```
    $ echo deb [arch=armhf] https://download.docker.com/linux/raspbian stretch stable > /etc/apt/sources.list.d/docker.list
    $ apt-get update
    ```

2. Clone the repo on your raspberry pi:

    ```
    $ git clone https://github.com/LoungeFlyZ/eyes-in-the-sky
    ```

3. Install docker-compose:

    ```
    $ sudo apt-get -y install python-setuptools && sudo easy_install pip  && sudo pip install docker-compose
    ```

4. Edit docker-compose.yml 

    ```
    $ nano docker-compose.yml
    ```
    
5. Replace the following environment configuration with your own settings:

    - `DUMP_LAT` - Your latitude
    - `DUMP_LON` - Your longitude
    - `DUMP_GMAP_KEY` - Your [Google Maps API Key](https://developers.google.com/maps/?hl=de)
    - `PIAWARE_USER` - Your FlightAware.com username
    - `PIAWARE_PASSWORD` - Your FlightAware.com password
    - `PIAWARE_FEEDER_ID` (Optional) - Your feeder id from FlightAware if you already have one

6. docker-compose up

    ```
    $ docker-compose -f docker-compose.yml up -d
    ```
    
7. browse to your raspberry pi's ip address on port 8080
 
    [http://192.168.1.200:8080](http://192.168.1.200:8080) _(replace with your ip)_
    
You should now see dump1090's web interface.

## Setting your feeder id -- FlightAware.com

Log into your FlightAware account and find your new feeder on the "My ADS-B" page. Every time a new feeder is detected FlightAware assigns a unique identifier (guid) to it. To ensure your piaware container is not seen as a new feeder each time it is restarted you need to get the "unique identifier" from your My ADS-B stats page and set it in the docker-compose.yml file.

    ```
    - PIAWARE_FEEDER_ID=532e29ff-ed56-4b7b-72b6-12b56313b49a
    ```

This will ensure that when your piaware container is restarted that it is seen as the same feeder in flightaware. 

## Setting your feeder key -- FlightRadar24.com (optional)

Before you can feed FlightRadar24.com you need to create an account on their website. Then you need to run the flightaware container with a signup command to register and generate your key.

If you dont want to feed FlightRadar24.com comment out the flightradar service in the docker-compose.yml


    ```
    $ docker run -it loungefly/raspbian-flightradar24 /usr/bin/fr24feed --signup
    ```

Step 1.1 Enter your accounts email address
Step 1.2 Leave blank
Step 1.3 yes
Step 3.A Enter your latitude
Step 3.B Enter your longitude
Step 3.C Enter your altitude in feet
Enter 'yes' to confirm

You should be given a key that you can copy and enter into the docker-compose.yml file in the FR24_KEY environment variable.

## Troubleshooting

- Check the logs for the dump1090 container

    ```
    $ docker logs dump1090
    ```

 - Check the logs for the dump1090 container

    ```
    $ docker logs flightradar24
    ```

- Check the logs for the piaware container

    ```
    $ docker logs piaware
    ```
    
