package main

import (
	"crypto/tls"
	"crypto/x509"
	"encoding/json"
	"fmt"
	"github.com/gorilla/websocket"
	"github.com/pion/webrtc/v3"
	"io/ioutil"
	"log"
	"os"
	"os/signal"
	"strings"
	"time"
)

type clientMessage struct {
	Type             string                   `json:"type"`
	Version          []string                 `json:"version"`
	Kind             string                   `json:"kind,omitempty"`
	Id               string                   `json:"id,omitempty"`
	Replace          string                   `json:"replace,omitempty"`
	Source           string                   `json:"source,omitempty"`
	Dest             string                   `json:"dest,omitempty"`
	Username         string                   `json:"username,omitempty"`
	Password         string                   `json:"password,omitempty"`
	Token            string                   `json:"token,omitempty"`
	Privileged       bool                     `json:"privileged,omitempty"`
	Permissions      []string                 `json:"permissions,omitempty"`
	Data             map[string]interface{}   `json:"data,omitempty"`
	Group            string                   `json:"group,omitempty"`
	GroupData        map[string]interface{}   `json:"group_data,omitempty"`
	Value            interface{}              `json:"value,omitempty"`
	NoEcho           bool                     `json:"noecho,omitempty"`
	Time             int64                    `json:"time,omitempty"`
	SDP              string                   `json:"sdp,omitempty"`
	Candidate        *webrtc.ICECandidateInit `json:"candidate,omitempty"`
	Label            string                   `json:"label,omitempty"`
	Request          interface{}              `json:"request,omitempty"`
	RTCConfiguration *webrtc.Configuration    `json:"rtcConfiguration,omitempty"`
}

func main() {
	// WebSocket URL
	url := "wss://pion.iosi.com.br:8443/ws"
	//wsDialer := websocket.DefaultDialer

	caCertFile := "iosi.crt"

	caCert, err := ioutil.ReadFile(caCertFile)
	if err != nil {
		log.Fatal(err)
	}

	caCertPool := x509.NewCertPool()
	caCertPool.AppendCertsFromPEM(caCert)

	tlsConfig := &tls.Config{
		RootCAs: caCertPool,
	}

	dialer := websocket.DefaultDialer
	dialer.TLSClientConfig = tlsConfig

	// Establish a connection to the WebSocket server
	conn, _, err := dialer.Dial(url, nil)
	if err != nil {
		log.Fatal("Error connecting to WebSocket server:", err)
	}
	defer conn.Close()

	// Create a channel to listen for OS interrupt signal (Ctrl+C)
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt)
	message := clientMessage{
		Type:    "handshake",
		Version: []string{"1"},
		Id:      "4050ce5ed0b18c41f3df2d06cf0fad44w5",
	}

	jsonValue, _ := json.Marshal(message)
	fmt.Println(string(jsonValue))

	var configrtc *webrtc.Configuration
	var peerConnection *webrtc.PeerConnection
	var usernameFragment string
	var passFragment string

	var idIce string

	//var idConnection string
	// Create a goroutine to read messages from the WebSocket server
	go func() {
		for {
			_, message, err := conn.ReadMessage()
			fmt.Printf("Received message: %s\n", message)

			if err != nil {
				log.Println("Error reading message:", err)
				return
			}
			var clientMsg clientMessage
			err2 := json.Unmarshal(message, &clientMsg)
			if err2 != nil {
				fmt.Println("Error:", err)
				//return
			}

			if clientMsg.Type == "handshake" {
				messageJoin := clientMessage{
					Type:     "join",
					Kind:     "join",
					Group:    "kaz-eofe-crs",
					Username: "rondinelli133@gmail.com",
					Password: "active",
				}
				jsonValue, _ := json.Marshal(messageJoin)
				conn.WriteMessage(websocket.TextMessage, jsonValue)

			} else if clientMsg.Type == "joined" && clientMsg.Kind == "join" {
				configrtc = clientMsg.RTCConfiguration

			} else if clientMsg.Type == "ping" {
				messagePong := clientMessage{
					Type: "pong",
				}
				jsonValue, _ := json.Marshal(messagePong)
				conn.WriteMessage(websocket.TextMessage, jsonValue)
			} else if clientMsg.Type == "user" && clientMsg.Username == "rondinelli133@gmail.com" {
				data := make(map[string][]string)

				// Add values to the map
				data[""] = []string{"audio", "video"}

				messagePong := clientMessage{
					Type:    "request",
					Request: data,
				}
				jsonValue, _ := json.Marshal(messagePong)
				//fmt.Println(string(jsonValue))

				conn.WriteMessage(websocket.TextMessage, jsonValue)

			} else if clientMsg.Type == "offer" {
				idIce = clientMsg.Id

				//peerConnection.CreateOffer(null)

				var s webrtc.SettingEngine
				s.SetHostAcceptanceMinWait(0)
				s.SetSrflxAcceptanceMinWait(0)
				s.SetPrflxAcceptanceMinWait(0)
				s.SetRelayAcceptanceMinWait(0)

				// Define the audio and video codecs you want to use

				me := &webrtc.MediaEngine{}

				// Define the audio and video codecs you want to use
				//audioCodec := webrtc.RTPCodecParameters{
				//	RTPCodecCapability: webrtc.RTPCodecCapability{
				//		MimeType:     "audio/opus",
				//		ClockRate:    48000,
				//		Channels:     2,
				//		SDPFmtpLine:  "minptime=10;useinbandfec=1",
				//		RTCPFeedback: []webrtc.RTCPFeedback{{"transport-cc", ""}},
				//	},
				//	PayloadType: 100,
				//}

				me.RegisterCodec(webrtc.RTPCodecParameters{
					RTPCodecCapability: webrtc.RTPCodecCapability{MimeType: webrtc.MimeTypeOpus, ClockRate: 48000, Channels: 2, SDPFmtpLine: "minptime=10;useinbandfec=1", RTCPFeedback: []webrtc.RTCPFeedback{{"transport-cc", ""}}},
					PayloadType:        111,
				}, webrtc.RTPCodecTypeAudio)

				me.RegisterCodec(webrtc.RTPCodecParameters{
					RTPCodecCapability: webrtc.RTPCodecCapability{
						MimeType:    "video/VP8",
						ClockRate:   90000,
						SDPFmtpLine: "max-fs=12288;max-fr=60",
					},
					PayloadType: 100,
				}, webrtc.RTPCodecTypeVideo)

				api := webrtc.NewAPI(webrtc.WithMediaEngine(me))

				peerConnection, err = api.NewPeerConnection(*configrtc)

				dataChannel, err := peerConnection.CreateDataChannel(clientMsg.Label, nil)
				if err != nil {
					log.Fatal(err)
				}

				// Set up data channel handlers
				dataChannel.OnMessage(func(msg webrtc.DataChannelMessage) {
					fmt.Printf("Received message: %s\n", msg.Data)
				})

				//offer, err := peerConnection.CreateOffer(nil)
				//fmt.Println(offer)

				if err != nil {
					panic(err)
				}

				// Set up an OnTrack event listener to handle incoming audio tracks
				peerConnection.OnTrack(func(track *webrtc.TrackRemote, receiver *webrtc.RTPReceiver) {
					if track.Kind() == webrtc.RTPCodecTypeAudio {
						fmt.Println("Received audio track")

						// Start reading and processing audio packets
						go func() {
							for {
								packet, _, err := track.ReadRTP()
								if err != nil {
									fmt.Println("Error reading RTP packet:", err)
									return
								}

								// Process the audio packet data here
								_ = packet
							}
						}()
					}
				})
				//idConnection = "12345678"
				if err != nil {
					panic(err)
				}
				defer peerConnection.Close()

				// Handle ICE candidates
				peerConnection.OnICECandidate(func(candidate *webrtc.ICECandidate) {
					if candidate == nil {
						// ICE candidate gathering complete
						fmt.Println("ICE candidate gathering complete")
					} else {
						// Handle individual ICE candidate, send it to the remote peer through signaling
						//fmt.Println("Got ICE candidate:", candidate.ToJSON().Candidate)
						cc := candidate.ToJSON()
						cc.UsernameFragment = &usernameFragment
						var sample string = "0"
						cc.SDPMid = &sample
						messageAnswer := clientMessage{
							Type:      "ice",
							Id:        idIce,
							Candidate: &cc,
						}
						jsonValue, _ := json.Marshal(messageAnswer)
						//fmt.Printf("write message: %s\n", jsonValue)
						conn.WriteMessage(websocket.TextMessage, jsonValue)
						peerConnection.AddICECandidate(cc)

					}
				})

				peerConnection.OnICEConnectionStateChange(func(connectionState webrtc.ICEConnectionState) {
					fmt.Printf("Connection State has changed %s \n", connectionState.String())
				})

				var desc webrtc.SessionDescription
				desc.Type = webrtc.SDPTypeOffer

				desc.SDP = clientMsg.SDP
				usernameFragment, passFragment = extractIceCredentials(clientMsg.SDP)
				print(usernameFragment)
				print(passFragment)

				//err = peerConnection.SetRemoteDescription(desc)

				if err != nil {
					panic(err)
				}

				err = peerConnection.SetRemoteDescription(desc)

				answer, err := peerConnection.CreateAnswer(nil)

				if err != nil {
					panic(err)
				}

				gatherComplete := webrtc.GatheringCompletePromise(peerConnection)

				err = peerConnection.SetLocalDescription(answer)

				<-gatherComplete

				messageAnswer := clientMessage{
					Type: "answer",
					Id:   clientMsg.Id,
					SDP:  answer.SDP,
				}
				jsonValue, _ := json.Marshal(messageAnswer)
				//fmt.Printf("write message: %s\n", jsonValue)

				conn.WriteMessage(websocket.TextMessage, jsonValue)

			} else if clientMsg.Type == "ice" {

				clientMsg.Candidate.UsernameFragment = &usernameFragment
				messageAnswer := clientMessage{
					Type:      "ice",
					Id:        idIce,
					Candidate: clientMsg.Candidate,
				}
				//
				//candidate = clientMsg.Candidate
				jsonValue, _ := json.Marshal(messageAnswer)

				conn.WriteMessage(websocket.TextMessage, jsonValue)

				//fmt.Printf("write message: %s\n", jsonValue)
				peerConnection.AddICECandidate(*clientMsg.Candidate)
			}
		}
	}()

	conn.WriteMessage(websocket.TextMessage, jsonValue)

	// Handling OnICECandidate event

	//conn.WriteMessage(message)

	// Main loop to send messages to the WebSocket server
	for {
		select {
		case <-interrupt:
			fmt.Println("Interrupt signal received. Closing connection...")
			err := conn.WriteMessage(websocket.CloseMessage, websocket.FormatCloseMessage(websocket.CloseNormalClosure, ""))
			if err != nil {
				log.Println("Error sending close message:", err)
				return
			}
			select {
			case <-time.After(time.Second):
			}
			return
		}
	}

}

func sendICE(c *websocket.Conn, id string, candidate *webrtc.ICECandidate) error {
	if candidate == nil {
		return nil
	}
	fmt.Printf("sendICE")
	cand := candidate.ToJSON()
	messageAnswer := clientMessage{
		Type:      "ice",
		Id:        id,
		Candidate: &cand,
	}
	jsonValue, _ := json.Marshal(messageAnswer)

	return c.WriteMessage(websocket.TextMessage, jsonValue)

}

func extractIceCredentials(sdpString string) (string, string) {
	var ufrag, pwd string

	lines := strings.Split(sdpString, "\r\n")
	for _, line := range lines {
		if strings.HasPrefix(line, "a=ice-ufrag:") {
			ufrag = strings.TrimPrefix(line, "a=ice-ufrag:")
		} else if strings.HasPrefix(line, "a=ice-pwd:") {
			pwd = strings.TrimPrefix(line, "a=ice-pwd:")
		}

		if ufrag != "" && pwd != "" {
			break
		}
	}

	return ufrag, pwd
}

func setRemoteDescription(pc *webrtc.PeerConnection, remoteSDP string) error {
	// Parse the remote SDP
	remoteSessionDescription := webrtc.SessionDescription{}
	remoteSDP = strings.TrimSpace(remoteSDP)
	remoteSessionDescription.SDP = remoteSDP

	// Set the type based on the SDP content (offer or answer)
	if strings.Contains(remoteSDP, "m=audio") {
		remoteSessionDescription.Type = webrtc.SDPTypeOffer
	} else {
		remoteSessionDescription.Type = webrtc.SDPTypeAnswer
	}

	// Set the remote description
	err := pc.SetRemoteDescription(remoteSessionDescription)
	if err != nil {
		return fmt.Errorf("error setting remote description: %v", err)
	}

	return nil
}
