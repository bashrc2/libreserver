<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// API for guifi.net
//
// License
// =======
//
// Copyright (C) 2005 by Eduard Duran <eduard.duran at iglu.cat>
// Adapted for LibreServer by Bob Mottram <bob@libreserver.org>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Client class for the guifi.net API
 *
 */
class guifiAPI
{
    /**
     * Which is the HTTP interface used by PHP to open HTTP connections
     * (either curl, fopen or autodetection)
     * @var string
     */
    const http_interface = 'auto';

    /**
     * guifi.net API URL used with normal metods
     * @var string
     */
    private $url_default = 'https://guifi.net/api';

    /**
     * guifi.net API URL used to authenticate the user
     * @var string
     */
    private $auth_url_default = 'https://guifi.net/api/auth';

    /**
     * test.guifi.net API URL used with normal methods
     * @var string
     */
    private $url_test = 'https://test.guifi.net/api';

    /**
     * test.guifi.net API URL used to authenticate the user
     * @var string
     */
    private $auth_url_test = 'https://test.guifi.net/api/auth';

    /**
     * API URL used with normal metods
     * @var string
     */
    private $url = '';

    /**
     * API URL used to authenticate the user
     * @var string
     */
    private $auth_url = '';

    /**
     * Whether the class is using the Development mode or not
     * @var boolean
     */
    const dev_mode = false;

    /**
     * What is the input format of the incoming responses from the API
     * @var string
     */
    const input_format = 'json';

    /**
     * What is the output format of the outcoming parameters to the API
     * @var string
     */
    const output_format = 'get';

    private $username = '';
    private $password = '';

    public $auth_token = null;
    private $errors = array();

    /**
     * Adds a zone to guifi.net
     * @param $title Title of the zone
     * @param $master Parent zone of the new zone
     * @param $miny Latitude coordinate, in decimal degrees, of the lower-left corner of the zone (SW)
     * @param $minx Longitude coordinate, in decimal degrees, of the lower-left corner of the zone (SW)
     * @param $maxy Latitude coordinate, in decimal degrees, of the upper-right corner of the zone (NE)
     * @param $maxx Longitude coordinate, in decimal degrees, of the upper-right corner of the zone (NE)
     * @param $parameters Extra parameters to create the zone
     * @return mixed An array with the zone_id, or false in case of failure
     */
    public function addZone($title, $master, $miny, $minx, $maxy, $maxx, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.zone.add';
        $variables['title'] = $title;
        $variables['master'] = $master;
        $variables['minx'] = $minx;
        $variables['miny'] = $miny;
        $variables['maxx'] = $maxx;
        $variables['maxy'] = $maxy;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);

        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Updates a guifi zone
     * @param $zone_id Zone ID to edit
     * @param $parameters Parameters to edit
     * @return boolean Whether the zone was edited or not
     */
    public function updateZone($zone_id, $parameters)
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.zone.update';
        $variables['zone_id'] = $zone_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Removes a guifi zone
     * @param $zone_id ID of the zone which should be removed
     * @return boolean Whether the zone was removed or not
     */
    public function removeZone($zone_id)
    {
        $variables = array();
        $variables['command'] = 'guifi.zone.remove';
        $variables['zone_id'] = $zone_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Gets the zone which can contain a certain point
     * @param $lat Latitude of the point
     * @param $lon Longitude of the point
     * @return mixed Nearest zones which can contain a certain point
     */
    public function nearestZone($lat, $lon)
    {
        $variables = array();
        $variables['command'] = 'guifi.zone.nearest';
        $variables['lat'] = $lat;
        $variables['lon'] = $lon;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);

        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Adds a new guifi.net node
     * @param $title Title of the node
     * @param $zone_id Zone ID of the node
     * @param $lat Latitude where the node is
     * @param $lon Longitude where the node is
     * @param $parameters Parameters to specify node settings
     * @return mixed Information of the newly created node (node_id)
     */
    public function addNode($title, $zone_id, $lat, $lon, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.node.add';
        $variables['title'] = $title;
        $variables['zone_id'] = $zone_id;
        $variables['lat'] = $lat;
        $variables['lon'] = $lon;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);

        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Updates a guifi node
     * @param $node_id Node ID to edit
     * @param $parameters Parameters to edit
     * @return boolean Whether the node was edited or not
     */
    public function updateNode($node_id, $parameters)
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.node.update';
        $variables['node_id'] = $node_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Removes a guifi node
     * @param $zone_id ID of the node which should be removed
     * @return boolean Whether the node was removed or not
     */
    public function removeNode($node_id)
    {
        $variables = array();
        $variables['command'] = 'guifi.node.remove';
        $variables['node_id'] = $node_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Adds a guifi device to a node
     * @param $node_id ID of the node where the device should be added
     * @param $type Type of device which should be added (radio, mobile, server, nat, generic, adsl, cam, phone)
     * @param $parameters Other parameters depending on the type of device, such as model_id, MAC address or firmware
     * @return mixed The response with the newly created device_id or false in case of error
     */
    public function addDevice($node_id, $type, $mac, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.device.add';
        $variables['node_id'] = $node_id;
        $variables['type'] = $type;
        $variables['mac'] = $mac;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Updates a guifi device
     * @param $device_id Device ID to edit
     * @param $parameters Parameters to edit
     * @return boolean Whether the device was edited or not
     */
    public function updateDevice($device_id, $parameters)
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.device.update';
        $variables['device_id'] = $device_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Removes a guifi device from a node
     * @param $device_id ID of the device which should be removed
     * @return boolean Whether the device was removed or not
     */
    public function removeDevice($device_id)
    {
        $variables = array();
        $variables['command'] = 'guifi.device.remove';
        $variables['device_id'] = $device_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Adds a guifi Radio to a device
     * @param $mode Mode of the radio to be added
     * @param $device_id Device where the radio should be added
     * @param $mac MAC address of the radio
     * @return mixed Information about the added radio, such as radiodev_counter
     */
    public function addRadio($mode, $device_id, $mac = '', $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.radio.add';
        $variables['mode'] = $mode;
        $variables['device_id'] = $device_id;
        $variables['mac'] = $mac;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Updates a guifi radio of a device
     * @param $device_id Device ID of the radio to be updated
     * @param $radiodev_counter Position within the device where the radio is location
     * @return boolean Whether the radio was updated or not
     */
    public function updateRadio($device_id, $radiodev_counter, $parameters)
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.radio.update';
        $variables['device_id'] = $device_id;
        $variables['radiodev_counter'] = $radiodev_counter;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Removes a guifi radio from a device
     * @param $device_id ID of the device where the radio to be removed is
     * @param $radiodev_counter Position within the device where the radio is
     * @return boolean Whether the radio was removed or not
     */
    public function removeRadio($device_id, $radiodev_counter)
    {
        $variables = array();
        $variables['command'] = 'guifi.radio.remove';
        $variables['device_id'] = $device_id;
        $variables['radiodev_counter'] = $radiodev_counter;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Searches the nearest radios from a given node
     * @param $node_id Node where to find the nearest radios
     * @param $parameters Parameters such as maximum or minimum distance
     * @return mixed Nearest radios from a given node
     */
    public function nearestRadio($node_id, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.radio.nearest';
        $variables['node_id'] = $node_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);

        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Adds a wLan interface to a radio to accept more clients
     * @param $device_id Device where the interface should be added
     * @param $radiodev_counter Position of the radio within the device where the interface should be added
     * @return mixed Information about the newly created interface, such as interface_id
     */
    public function addInterface($device_id, $radiodev_counter)
    {
        $variables = array();
        $variables['command'] = 'guifi.interface.add';
        $variables['device_id'] = $device_id;
        $variables['radiodev_counter'] = $radiodev_counter;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Removes a guifi interface from a radio
     * @param $interface_id ID of the interface to be removed
     * @return boolean Whether the interface was removed or not
     */
    public function removeInterface($interface_id)
    {
        $variables = array();
        $variables['command'] = 'guifi.interface.remove';
        $variables['interface_id'] = $interface_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Adds a link to an guifi.net interface
     * @param $from_device_id Device ID of the origin of the link
     * @param $from_radiodev_counter Position of the radio within its device of the origin of the link
     * @param $to_device_id Device ID of the other extreme of the link
     * @param $to_radiodev_counter Position of the radio within its device of the other extreme of the link
     * @param $parameters Other parameters of the link to be added
     * @return mixed Information about the newly created link, such as link_id
     */
    public function addLink($from_device_id, $from_radiodev_counter, $to_device_id, $to_radiodev_counter, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.link.add';
        $variables['from_device_id'] = $from_device_id;
        $variables['from_radiodev_counter'] = $from_radiodev_counter;
        $variables['to_device_id'] = $to_device_id;
        $variables['to_radiodev_counter'] = $to_radiodev_counter;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if ($body !== false) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Updates a guifi link
     * @param $link_id Link ID to be updated
     * @param $parameters Parameters of the link to be updated
     * @return boolean Whether the link was updated or not
     */
    public function updateLink($link_id, $parameters)
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.link.update';
        $variables['link_id'] = $link_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Removes a link from guifi.net
     * @param $link_id Link ID to be removed
     * @return boolean Whether the link was removed or not
     */
    public function removeLink($link_id)
    {
        $variables = array();
        $variables['command'] = 'guifi.link.remove';
        $variables['link_id'] = $link_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        return $body !== false;
    }

    /**
     * Gets a list of devices models
     * @param $parameters string[] of possible parameters to retrieve filtered models
     * @return string[] Models retrieved from the server
     */
    public function getModels($parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.misc.model';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses->models)) {
            return $body->responses->models;
        } else {
            return false;
        }
    }

    /**
     * Gets a list of device manufacturers
     * @return string[] Manufacturers retrieved from the server
     */
    public function getManufacturers()
    {
        $variables = array();
        $variables['command'] = 'guifi.misc.manufacturer';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses->manufacturers)) {
            return $body->responses->manufacturers;
        } else {
            return false;
        }
    }

    /**
     * Gets a list of supported firmwares to be used with devices
     * @param $parameters Firmware filters to be applied
     * @return string[] Firmwares retrieved from the server
     */
    public function getFirmwares($parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.misc.firmware';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses->firmwares)) {
            return $body->responses->firmwares;
        } else {
            return false;
        }
    }

    /**
     * Gets a list of supported protocols to be used with links
     * @return string[] Protocols retrieved from the server
     */
    public function getProtocols()
    {
        $variables = array();
        $variables['command'] = 'guifi.misc.protocol';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses->protocols)) {
            return $body->responses->protocols;
        } else {
            return false;
        }
    }

    /**
     * Gets a list of channels to be used with links
     * @param $protocol Protocol the channels apply to
     * @return string[] Channels retrieved from the server
     */
    public function getChannels($protocol)
    {
        $variables = array();
        $variables['command'] = 'guifi.misc.channel';
        $variables['protocol'] = $protocol;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses->channels)) {
            return $body->responses->channels;
        } else {
            return false;
        }
    }


    /* Services */
    /**
     * Add new service to server device.
     * @param $name: Name of service
     *        $server_id: device id from server.
     *        $service_type: type of service.
     *
     * parameters in array: nick -> Unique name of service.
     *                      status -> Status of service.
     * @return string[]
     */
    public function addService($name, $server_id, $service_type, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.service.add';
        $variables['name'] = $name;
        $variables['server_id'] = $server_id;
        $variables['service_type'] = $service_type;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Get service.
     * @param $service_id: device id from server.
     * @return string[] Service Information.
     */
    public function getService($service_id)
    {
        $variables = array();

        $variables['command'] = 'guifi.service.get';
        $variables['service_id'] = $service_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Update service.
     * @param $service: device id from server.
     *
     * parameters in array: nick -> Unique name of service.
     *                      status -> Status of service.
     *                      server_id -> Server device of service.
     *                      name -> Name of service.
     * @return string[]
     */
    public function updateService($service_id, $parameters = array())
    {
        $variables = array();

        foreach ($parameters as $key => $value) {
            $variables[$key] = $value;
        }

        $variables['command'] = 'guifi.service.update';
        $variables['service_id'] = $service_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Delete service.
     * @param $service_id: device id from server.
     * @return string[] Service Information.
     */
    public function removeService($service_id)
    {
        $variables = array();

        $variables['command'] = 'guifi.service.remove';
        $variables['service_id'] = $service_id;

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Get List of service types.
     * @param : --
     * @return string[] List of service types.
     */
    public function getListServices($service_id)
    {
        $variables = array();

        $variables['command'] = 'guifi.service.types';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }

    /**
     * Clear CNML.
     * @param : --
     * @return string[] List of service types.
     */
    public function clearCnml()
    {
        $variables = array();

        $variables['command'] = 'guifi.cnml.clear';

        $response = $this->sendRequest($this->url, $variables);
        $body = $this->parseResponse($response);
        if (!empty($body->responses)) {
            return $body->responses;
        } else {
            return false;
        }
    }
    /**
     * Constructor function for all new guifiAPI instances
     *
     * Set up authentication with guifi and gets authentication token
     *
     * @param String $username Username of the guifi.net account wanted to authenticate
     * @param String $password Password of the guifi.net account wanted to authenticate
     * @param String $token If any token is given, no need to send the username and password to the server
     * @param String $apiurl if you need change url to server.
     * @param String $apiauthurl if you need change url auth to server.
     */
    public function __construct($username, $password, $token = null, $apiurl = null, $apiauthurl = nul)
    {
        $this->username = $username;
        $this->password = $password;
        $this->url = (empty($apiurl)) ? $this->url_default : $apiurl;
        $this->auth_url = (empty($apiauthurl)) ? $this->auth_url_default : $apiauthurl;

        if (!empty($token)) {
            $this->auth_token = $token;
        } else {
            $this->authenticateUser($username, $password);
        }
    }

    /**
     * Authenticate guifi.net account against guifi.net
     *
     * @param string $email
     * @param string $password
     * @return boolean Whether the authentication was successful or not
     */
    protected function authenticateUser($username, $password)
    {
        $variables = array('command' => 'guifi.auth.login', 'username' => $username, 'password' => $password, 'method' => 'password' );

        $response = $this->sendRequest($this->auth_url, $variables);

        // Parses the response from the guifi.net API
        $body = $this->parseResponse($response);
        if ($body !== false) {
            $responses = $body->responses;
            if (!empty($responses->authToken)) {
                $this->auth_token = $responses->authToken;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * Retreives the authentication token used to authenticate the user in upcoming methods without sending the username and password each time
     * @return string Authentication token
     */
    public function getAuthToken()
    {
        return $this->auth_token;
    }

    /**
     * Generates the authentication header to authenticate using a token against guifi.net
     * @return mixed Header of authentication
     */
    protected function generateAuthHeader()
    {
        if ($this->auth_token) {
            return array('Authorization: GuifiLogin auth=' . $this->auth_token );
        } else {
            return array();
        }
    }

    /**
     * Performs the request to the guifi.net API server
     * @param $url URL to send the request to
     * @param $variables Variables to be formatted to be sent to the server
     * @return mixed response from the API server
     */
    protected function sendRequest($url, $variables)
    {
        $this->pendingUrl = $url;
        $this->pendingVariables = $variables;

        switch (guifiAPI::output_format) {
      case 'get':
        $get_variables = $variables;
        $post_variables = array();
        break;
      case 'post':
        $get_variables = array();
        $post_variables = $variables;
        break;
    }

        $response = $this->httpRequest($url, $get_variables, $post_variables, $this->generateAuthHeader());
        return $response;
    }

    /**
     * Parses a response from the server, according ti the input format
     * @param $response Response string to be parsed
     * @return mixed Returns the body of the response in case of success, false in case of failure
     */
    protected function parseResponse($response)
    {
        $code = $response['code'];

        switch (guifiAPI::input_format) {
      case 'json':
        $body = json_decode($response['body']);
        break;
      case 'url':
        parse_str(str_replace(array("\n", "\r\n" ), '&', $response['body']), $body);
        break;
    }

        if (substr($code, 0, 1) != '2' || !is_object($body)) {
            //throw new Exception('guifiAPI: Failed to parse response. Error: "' . strip_tags($response['body']) . '"');
        }

        if (!empty($body->errors)) {
            if ($body->errors[0]->code == 502) {
                unset($this->auth_token);
                $pendingUrl = $this->pendingUrl;
                $pendingVariables = $this->pendingVariables;
                $authenticated = $this->authenticateUser($this->username, $this->password);

                if ($authenticated) {
                    $response = $this->sendRequest($pendingUrl, $pendingVariables);
                    return $this->parseResponse($response);
                }
            }
            $this->errors = $body->errors;

            return false;
        }

        if (empty($body->code) || substr($body->code->code, 0, 1) != '2') {
            return false;
        }

        $this->responseCode = $body->code;
        if (isset($body->responses)) {
            $this->responses = $body->responses;
        }

        return $body;
    }

    /**
     * Retreives the possible errors commited during a method
     * @return string[]
     */
    public function getErrors()
    {
        return $this->errors;
    }

    /**
     * Retreives a list of the errors parsed as a string
     *
     * @param string $format Format of the list, either 'html' or 'plain'
     * @return string List of formatted errors
     */
    public function getErrorsStr($format = 'html')
    {
        $ret = '';
        if (!$this->errors) {
            return $ret;
        }
        if ($format == 'html') {
            $ret .= '<ul>';
        }
        foreach ($this->errors as $error) {
            if ($format == 'html') {
                $ret .= '<li>';
            }
            $ret .= "Code $error->code: $error->str";
            if (isset($error->extra)) {
                $ret .= " (Extra: $error->extra)";
            }
            if ($format == 'html') {
                $ret .= '</li>';
            } elseif ($format == 'plain') {
                $ret .= "\n";
            }
        }
        if ($format == 'html') {
            $ret .= '</ul>';
        }
        return $ret;
    }

    /**
     * Perform HTTP request
     *
     * @param array $get_variables
     * @param array $post_variables
     * @param array $headers
     */
    protected function httpRequest($url, $get_variables = null, $post_variables = null, $headers = null)
    {
        $interface = guifiAPI::http_interface;

        if (guifiAPI::http_interface == 'auto') {
            if (function_exists('curl_exec')) {
                $interface = 'curl';
            } else {
                $interface = 'fopen';
            }
        }

        if ($interface == 'curl') {
            return $this->curlRequest($url, $get_variables, $post_variables, $headers);
        } elseif ($interface == 'fopen') {
            return $this->fopenRequest($url, $get_variables, $post_variables, $headers);
        } else {
            throw new Exception('Invalid http interface defined. No such interface "' . GA_api::http_interface . '"');
        }
    }
    /**
     * HTTP request using PHP CURL functions
     * Requires curl library installed and configured for PHP
     *
     * @param array $get_variables
     * @param array $post_variables
     * @param array $headers
     */
    private function curlRequest($url, $get_variables = null, $post_variables = null, $headers = null)
    {
        $ch = curl_init();

        if (is_array($get_variables)) {
            $get_variables = '?' . str_replace('&amp;', '&', http_build_query($get_variables));
        } else {
            $get_variables = null;
        }

        curl_setopt($ch, CURLOPT_URL, $url . $get_variables);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

        if (is_array($post_variables)) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post_variables);
        }

        if (is_array($headers)) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }

        curl_setopt($ch, CURLOPT_HEADER, true);
        $response = curl_exec($ch);

        $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $headers = substr($response, 0, $header_size);
        $body = substr($response, $header_size);

        curl_close($ch);

        $ret=array('body' => $body, 'headers' => $headers, 'code' => $code );

        return($ret);
    }

    /**
     * Switches to test mode
     * @param $test Whether to switch to test mode or not
     */
    public function testMode($test = false)
    {
        $this->url = ($test) ? $this->url_test : $this->url_default;
        $this->auth_url = ($test) ? $this->auth_url_test : $this->auth_url_default;
    }
}

function createservice_get()
{
    global $staticPath, $Parameters, $GUIFI_CONF_DIR, $GUIFI_CONF_FILE, $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH, $services_types;

    if (isset($Parameters[0])) {
        $service = $Parameters[0];
        $stype = $services_types[$service];
        $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
        $gapi = new guifiAPI($GUIFI['USERNAME'], '', $GUIFI['TOKEN'], $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH);
        $gapi->addService($service.$GUIFI['DEVICEID'], $GUIFI['DEVICEID'], $stype['name'], array('nick'=>$stype['prenick'].$GUIFI['DEVICEID']));

        foreach ($gapi->getErrors() as $error) {
            if ($error -> code == 502) {
                break;
            }
        }
        if ((isset($error) && isset($error -> code) && $error -> code == 502) || ($gapi->getAuthToken() == "")) {
            #return(array('type' => 'render','page' => _reask_credentials(array('label'=>t("guifi-web_button_back"),'href'=>'javascript:history.back()')) ));
            return;
        };

        $gapi->clearCnml();
        return(array('type' => 'redirect', 'url' => $stype['function']));
    } else {
        return(array('type' => 'redirect', 'url' => $staticPath));
    }
}

function createservice_post()
{
    global $Parameters,$services_types, $_POST, $staticFile, $controller, $action, $staticPath;

    if (!isset($Parameters[0]) || !isset($services_types[$Parameters[0]])) {
        return(array('type' => 'redirect', 'url' => $staticPath));
    }
    $stype = $services_types[$Parameters[0]];

    $page = _check_credentials(
        $_POST,
            array('label'=>t("guifi-web_button_back_credentials"),'href'=>$staticFile.'/'.$controller.'/createservice/'.$Parameters[0]),
            array('label'=>t("guifi-seguir"),'href'=>$staticFile.'/'.$controller.'/createservice/'.$Parameters[0]),
            array('label'=>t("guifi-web_button_back"),'href'=>$staticFile)
    );

    return(array('type' => 'render','page' => $page));
}

function _getServiceInformation($type)
{
    global $GUIFI_WEB,$GUIFI_CONF_DIR,$GUIFI_CONF_FILE;

    if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
        return false;
    }
    $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
    $page = "";
    $url = $GUIFI_WEB."/guifi/cnml/".$GUIFI['NODEID']."/node";
    $resposta = _getHttp($url);
    if ($resposta) {
        $output = new SimpleXMLElement($resposta);
        foreach ($output->node->device as $k=>$device) {
            if ($device['id'] == $GUIFI['DEVICEID']) {
                if (isset($device->service)) {
                    foreach ($device->service as $service) {
                        if ($service['type'] == $type) {
                            return ($service);
                            break;
                        }
                    }
                }
            }
        }
    }
    return false;
}
function _reask_credentials($back)
{
    global $staticFile, $GUIFI_CONF_DIR, $GUIFI_CONF_FILE;

    $page = "";
    $buttons = "";

    $page .= hlc(t("guifi-web_common_title"));
    $page .= hl(t("guifi-web_refresh_credentials_subtitle"), 4);

    $page .= par(t("guifi-web_refresh_credentials_description"));

    if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE) || !filesize($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
        $page .= "<div class='alert alert-warning text-center'>".t("guifi-web_alert_index_not_registered")."</div>\n";
        $page .= par(t("guifi-web_index_not_registered"));
        $buttons .= addButton(array('label'=>t("guifi-web_button_register"),'class'=>'btn btn-success', 'href'=>$staticFile.'/guifi-web/credentials'));
    } else {
        $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);

        if ($GUIFI['USERNAME']==null) {
            $page .= "<div class='alert alert-warning text-center'>".t("guifi-web_alert_index_not_registered")."</div>\n";
            $page .= par(t("guifi-web_index_not_registered"));
            $buttons .= addButton(array('label'=>t("guifi-web_button_register"),'class'=>'btn btn-success', 'href'=>$staticFile.'/guifi-web/credentials'));
        } else {
            $form = createForm(array('class'=>'form-horizontal'));
            $form .= addInput('USERNAME', t("guifi-web_refresh_credentials_form_username"), $GUIFI['USERNAME'], array('type'=>'text','required'=>true,'pattern'=>'[A-Za-z0-9_-\s\.]+','readonly'=>true), '', t("guifi-web_refresh_credentials_form_username_tooltip"));
            $form .= addInput('PASSWORD', t("guifi-web_refresh_credentials_form_password"), '', array('type'=>'password', 'required'=>true), '', t("guifi-web_refresh_credentials_form_password_tooltip"));

            $fbuttons = addSubmit(array('label'=>t('guifi-web_button_submit_refresh'),'class'=>'btn btn-primary'));

            $page .= $form;

            $page .= txt(t("guifi-web_refresh_credentials_security"));
            $page .= "<div class='alert alert-info text-center'>".t("guifi-web_alert_refresh_credentials_security_username").' '.$GUIFI_CONF_DIR.$GUIFI_CONF_FILE."</div>\n";
            $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_refresh_credentials_security_password")."</div>\n";
            $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_refresh_credentials_security_ssl")."</div>\n";

            $buttons .= addButton(array('label'=>$back['label'],'class'=>'btn btn-default', 'href'=>$back['href']));
            $buttons .= $fbuttons;
        }
    }
    $page .= $buttons;

    return($page);
}

function _recheck_credentials($post, $error, $callback, $back)
{
    global $staticFile, $GUIFI_CONF_DIR, $GUIFI_CONF_FILE, $GUIFI_WEB, $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH ;

    $page = "";
    $buttons = "";

    $page .= hlc(t("guifi-web_common_title"));
    $page .= hl(t("guifi-web_credentials_subtitle"), 4);

    if (empty($post)) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_empty")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_empty"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } elseif (empty($post['USERNAME'])) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_emptyusername")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_emptyusername"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } elseif (empty($post['PASSWORD'])) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_emptypassword")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_emptypassword"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } else {
        $gapi = new guifiAPI($post['USERNAME'], $post['PASSWORD'], null, $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH);

        //$page .= ptxt(print_r($gapi, true));

        //Server could not be reached
        if (!isset($gapi->responseCode) && $gapi->getErrors() == null) {
            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_curl_empty")."</div>\n";
            $page .= par(t("guifi-web_credentials_curl_empty"));
            $page .= txt(t("guifi-web_credentials_curl_url"));
            $page .= "<div class='alert alert-info text-center'>".$GUIFI_WEB."/api?command=guifi.auth.login&username=".$post['USERNAME']."&password=********</div>\n";
            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
        }

        //Server was reached
        elseif (isset($gapi->responseCode) || isset($gapi->getErrors()[0])) {

            //In case of error
            if ($gapi->getErrors()) {
                $page .= _handle_error(null, $gapi->getErrors(), 'refresh_credentials', null);
            }

            //No error (apparently)
            elseif (isset($gapi->responseCode)) {
                switch ($gapi->responseCode->code) {
                    //Success
                    case 200:
                        $page .= txt(t("guifi-web_credentials_curl_authresult"));
                        $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_curl_ok")."</div>\n";
                        $page .= txt(t("guifi-web_credentials_curl_details"));
                        $page .= ptxt(print_r($gapi->responses, true));

                        if (file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
                        }
                        if (!file_exists($GUIFI_CONF_DIR)) {
                            mkdir($GUIFI_CONF_DIR, 0755);
                        }
                        if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            touch($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
                        }
                        if (fileperms($GUIFI_CONF_DIR.$GUIFI_CONF_FILE) != "16877") {
                            chmod($GUIFI_CONF_DIR.$GUIFI_CONF_FILE, 0644);
                        }

                        $GUIFI['USERNAME'] = $post['USERNAME'];
                        $GUIFI['TOKEN'] = $gapi->responses->authToken;

                        write_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE, add_quotes($GUIFI));

                        //Check if config file has been saved
                        if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            $page .= txt(t("guifi-web_credentials_saving"));
                            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_error")."</div>\n";
                            $page .= par(t("guifi-web_credentials_file_error"));
                            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                        }

                        /* This does not work as the config. file is written asynchronously
                        else if ( filesize($GUIFI_CONF_DIR.$GUIFI_CONF_FILE) == 0 ) {
                            $page .= txt(t("guifi-web_credentials_saving"));
                            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_empty")."</div>\n";
                            $page .= par(t("guifi-web_credentials_file_empty"));
                            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                        }
                        */

                        //Good. Check that the config file contents are correct
                        else {
                            $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);

                            //Ooops, something was not properly saved
                            if ($GUIFI['USERNAME'] != $post['USERNAME'] || $GUIFI['TOKEN'] != $gapi->responses->authToken) {
                                $page .= txt(t("guifi-web_credentials_saving"));
                                $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_different")."</div>\n";
                                $page .= par(t("guifi-web_credentials_file_different"));
                                $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                            }

                            //Good, data was saved correctly
                            else {
                                $page .= txt(t("guifi-web_credentials_saving"));
                                $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_file_correct")."</div>\n";
                                $page .= par(t("guifi-web_refresh_credentials_success"));
                                $buttons .= addButton(array('label'=>$back['label'],'class'=>'btn btn-default', 'href'=>$back['href']));
                                $buttons .= addButton(array('label'=>$callback['label'],'class'=>'btn btn-success', 'href'=>$callback['href']));
                            }
                        }
                        break;

                    default:
                        $page .= txt(t("guifi-web_credentials_curl_authresult"));
                        break;
                }
            }
        }
    }

    $page .= $buttons;

    return($page);
}

function _ask_credentials($back)
{
    global $staticPath, $GUIFI_CONF_DIR, $GUIFI_CONF_FILE;

    if (file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
        $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
        //unset($GUIFI['TOKEN']);
        //write_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE, add_quotes($GUIFI));
    }

    $page = "";
    $buttons = "";

    $page .= hlc(t("guifi-web_common_title"));
    $page .= hl(t("guifi-web_credentials_subtitle"), 4);

    $page .= par(t("guifi-web_credentials_description"));

    $form = createForm(array('class'=>'form-horizontal'));
    $form .= addInput('USERNAME', t("guifi-web_credentials_form_username"), '', array('type'=>'text','required'=>true,'pattern'=>'[A-Za-z0-9_-\s\.]+'), '', t("guifi-web_credentials_form_username_tooltip"));
    $form .= addInput('PASSWORD', t("guifi-web_credentials_form_password"), '', array('type'=>'password', 'required'=>true), '', t("guifi-web_credentials_form_password_tooltip"));

    $fbuttons = addSubmit(array('label'=>t('guifi-web_button_submit_check'),'class'=>'btn btn-primary'));

    $page .= $form;

    $page .= txt(t("guifi-web_credentials_security"));
    $page .= "<div class='alert alert-info text-center'>".t("guifi-web_alert_credentials_security_username").' '.$GUIFI_CONF_DIR.$GUIFI_CONF_FILE."</div>\n";
    $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_security_password")."</div>\n";
    $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_security_ssl")."</div>\n";

    $buttons .= addButton(array('label'=>$back['label'],'class'=>'btn btn-default', 'href'=>$back['href']));
    $buttons .= $fbuttons;

    $page .= $buttons;

    return($page);
}

function _check_credentials($post, $error, $callback, $back)
{
    global $staticFile, $GUIFI_CONF_DIR, $GUIFI_CONF_FILE, $GUIFI_WEB, $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH ;

    $page = "";
    $buttons = "";

    $page .= hlc(t("guifi-web_common_title"));
    $page .= hl(t("guifi-web_credentials_subtitle"), 4);

    if (empty($post)) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_empty")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_empty"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } elseif (empty($post['USERNAME'])) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_emptyusername")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_emptyusername"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } elseif (empty($post['PASSWORD'])) {
        $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_post_emptypassword")."</div>\n";
        $page .= par(t("guifi-web_credentials_post_emptypassword"));
        $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
    } else {
        $gapi = new guifiAPI($post['USERNAME'], $post['PASSWORD'], null, $GUIFI_WEB_API, $GUIFI_WEB_API_AUTH);

        //$page .= ptxt(print_r($gapi, true));

        //Server could not be reached
        if (!isset($gapi->responseCode) && $gapi->getErrors() == null) {
            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_curl_empty")."</div>\n";
            $page .= par(t("guifi-web_credentials_curl_empty"));
            $page .= txt(t("guifi-web_credentials_curl_url"));
            $page .= "<div class='alert alert-info text-center'>".$GUIFI_WEB."/api?command=guifi.auth.login&username=".$post['USERNAME']."&password=********</div>\n";
            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
        }

        //Server was reached
        elseif (isset($gapi->responseCode) || isset($gapi->getErrors()[0])) {

            //In case of error
            if ($gapi->getErrors()) {
                $page .= _handle_error(null, $gapi->getErrors(), 'credentials', null);
            }

            //No error (apparently)
            elseif (isset($gapi->responseCode)) {
                switch ($gapi->responseCode->code) {
                    //Success
                    case 200:
                        $page .= txt(t("guifi-web_credentials_curl_authresult"));
                        $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_curl_ok")."</div>\n";
                        $page .= txt(t("guifi-web_credentials_curl_details"));
                        $page .= ptxt(print_r($gapi->responses, true));

                        if (file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
                        }
                        if (!file_exists($GUIFI_CONF_DIR)) {
                            mkdir($GUIFI_CONF_DIR, 0755);
                        }
                        if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            touch($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);
                        }
                        if (fileperms($GUIFI_CONF_DIR.$GUIFI_CONF_FILE) != "16877") {
                            chmod($GUIFI_CONF_DIR.$GUIFI_CONF_FILE, 0644);
                        }

                        $GUIFI['USERNAME'] = $post['USERNAME'];
                        $GUIFI['TOKEN'] = $gapi->responses->authToken;

                        write_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE, add_quotes($GUIFI));

                        //Check if config file has been saved
                        if (!file_exists($GUIFI_CONF_DIR.$GUIFI_CONF_FILE)) {
                            $page .= txt(t("guifi-web_credentials_saving"));
                            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_error")."</div>\n";
                            $page .= par(t("guifi-web_credentials_file_error"));
                            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                        }

                        /* This does not work as the config. file is written asynchronously
                        else if ( filesize($GUIFI_CONF_DIR.$GUIFI_CONF_FILE) == 0 ) {
                            $page .= txt(t("guifi-web_credentials_saving"));
                            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_empty")."</div>\n";
                            $page .= par(t("guifi-web_credentials_file_empty"));
                            $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                        }
                        */

                        //Good. Check that the config file contents are correct
                        else {
                            $GUIFI=load_conffile($GUIFI_CONF_DIR.$GUIFI_CONF_FILE);

                            //Ooops, something was not properly saved
                            if ($GUIFI['USERNAME'] != $post['USERNAME'] || $GUIFI['TOKEN'] != $gapi->responses->authToken) {
                                $page .= txt(t("guifi-web_credentials_saving"));
                                $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_credentials_file_different")."</div>\n";
                                $page .= par(t("guifi-web_credentials_file_different"));
                                $buttons .= addButton(array('label'=>$error['label'],'class'=>'btn btn-warning', 'href'=>$error['href']));
                            }

                            //Good, data was saved correctly
                            else {
                                $page .= txt(t("guifi-web_credentials_saving"));
                                $page .= "<div class='alert alert-success text-center'>".t("guifi-web_alert_credentials_file_correct")."</div>\n";
                                $page .= par(t("guifi-web_credentials_register"));
                                $buttons .= addButton(array('label'=>$back['label'],'class'=>'btn btn-default', 'href'=>$back['href']));
                                $buttons .= addButton(array('label'=>$callback['label'],'class'=>'btn btn-success', 'href'=>$callback['href']));
                            }
                        }
                        break;

                    default:
                        $page .= txt(t("guifi-web_credentials_curl_authresult"));
                        break;
                }
            }
        }
    }
    $page .= $buttons;
    return($page);
}

function _handle_error($post, $error, $callback, $back)
{
    $buttons = '';
    $page = '';

    $page .= txt(t("guifi-api_handle_error_call_result:"));
    $page .= "<div class='alert alert-error text-center'>".t("guifi-api_alert_error")."</div>\n";
    $page .= txt(t("guifi-api_handle_error_details:"));
    $page .= ptxt(print_r($error, true));

    switch ($error[0]->code) {
        case 403:
            switch ($error[0]->extra) {
                case 'Either the supplied username or password are not correct':
                    $page .= txt(t("guifi-api_handle_error_found:"));
                    $page .= "<div class='alert alert-error text-center'>".t("guifi-api_alert_error_403_login")."</div>\n";
                    $page .= par(t("guifi-api_handle_error_403_login"));
                    $buttons .= addButton(array('label'=>t("guifi-web_button_back"),'class'=>'btn btn-default', 'href'=>$staticFile.'/guifi-web'));
                    $buttons .= addButton(array('label'=>t("guifi-web_button_back_credentials"),'class'=>'btn btn-warning', 'href'=>$staticFile.'/guifi-web/'.$callback));
                    break;

                case 'nick already in use':
                    $page .= txt(t("guifi-api_handle_error_found:"));
                    $page .= "<div class='alert alert-error text-center'>".$post['DEVICENAME'].': '.t("guifi-web_alert_new_libreserver_post_already_in_use")."</div>\n";
                    $page .= par(t("guifi-web_new_libreserver_post_already_in_use"));
                    $buttons .= addButton(array('label'=>t("guifi-web_button_back"),'class'=>'btn btn-default', 'href'=>$staticFile.'/guifi-web'));
                    $buttons .= addButton(array('label'=>t("guifi-web_button_back_add"),'class'=>'btn btn-warning', 'href'=>$staticFile.'/guifi-web/newlibreserver'));
                    break;

                default:
                    $page .= par(t("guifi-api_handle_error_403_default"));
                    $buttons .= addButton(array('label'=>t("guifi-web_button_back"),'class'=>'btn btn-default', 'href'=>$staticFile.'/guifi-web'));

                    break;
            }
            break;
        case 500:
            $page .= txt(t("guifi-api_handle_error_found:"));
            $page .= "<div class='alert alert-error text-center'>".t("guifi-api_alert_error_500")."</div>\n";
            $page .= par(t("guifi-api_handle_error_500"));
            $buttons .= addButton(array('label'=>t("guifi-web_button_back"),'class'=>'btn btn-default', 'href'=>$staticFile.'/guifi-web'));
            $buttons .= addButton(array('label'=>t('guifi-web_button_change_deviceid'),'class'=>'btn btn-warning', 'href'=>$staticFile.'/guifi-web/selectdevice'));
            $buttons .= addButton(array('label'=>t("guifi-web_button_noip"),'class'=>'btn btn-warning', 'href'=>$staticFile.'/guifi-web'));
            break;

        case 501:
            $page .= txt(t("guifi-api_handle_error_found:"));
            $page .= "<div class='alert alert-error text-center'>".t("guifi-api_alert_error_501")."</div>\n";
            $page .= par(t("guifi-api_handle_error_501"));
            $buttons = addButton(array('label'=>t('guifi-web_button_submit_refresh'),'class'=>'btn btn-warning', 'href'=>$staticFile.'/guifi-web/credentials'.$callback));
            break;

        case 502:
            $page .= txt(t("guifi-web_new_libreserver_post_error"));
            $page .= "<div class='alert alert-error text-center'>".t("guifi-web_alert_new_libreserver_post_expired")."</div>\n";
            $page .= par(t("guifi-web_new_libreserver_credentials_expired"));
            $buttons = addButton(array('label'=>t('guifi-web_button_submit_refresh'),'class'=>'btn btn-primary', 'href'=>$staticFile.'/guifi-web/credentials'.$callback));
            break;

        default:
            $page .= par(t("guifi-web_new_libreserver_fail"));
    }

    $page .= $buttons;
    return ($page);
}

function serviceDeclared($serviceType)
{
    global $services_types;

    $buttons = "";
    $page = "";

    $guifiWebService = _getServiceInformation($services_types[$serviceType]['name']);

    if (isset($guifiWebService['id'])) {
        return true;
    }

    return false;
}
