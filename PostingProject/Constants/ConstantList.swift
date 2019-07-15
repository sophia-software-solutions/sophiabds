//
//  ConstantList.swift
//  AssetIntelligence
//
//  Created by LUCAS on 3/18/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import SwiftDate
import CoreLocation
import Foundation
import CoreBluetooth

struct C {
    struct StoryboardID {
        static let storyboardName = "Main"
        static let landing = "LandingScreen"
        static let tabbar = "TabbarScreen"
    }
    
    struct URL {
        static let base = "http://pipeline.atomiton.com:8080/fid-SmartMeter"
        static let authorization = "http://pipeline.atomiton.com:8080/fid-Authentication/login"
        static let testImage = "http://13.59.85.45:8080/fid-smartmeter"
        static let imageFolder = "http://pipeline.atomiton.com:8080/fid-tqlengineres/smartmeterimg/"
    }
    
    struct Router {
        static let stationURL = "http://pipeline.atomiton.com:8080/fid-SmartMeter"
    }
    
    struct KVO {
        static var context = "PullToRefreshKVOContext"
        
        enum ScrollViewPath {
            static let contentOffset = #keyPath(UIScrollView.contentOffset)
            static let contentInset = #keyPath(UIScrollView.contentInset)
            static let contentSize = #keyPath(UIScrollView.contentSize)
        }
    }
    
    struct GoogleCerts {
        static let clientID = "790900901397-s6fou4u7b4siuo99tucum3fa4cpn0p9m.apps.googleusercontent.com"
        static let reservedCientID = "com.googleusercontent.apps.790900901397-s6fou4u7b4siuo99tucum3fa4cpn0p9m"
    }
    
    struct segueID {
        //Setup flows
        static let toSignUpSegueID = "toSignUp"
        static let toSignInSegueID = "toSignIn"
        static let toHomeSegueID = "toHome"
        static let toDeviceScanSegueID = "toDeviceScan"
        static let toDeviceLoginSegueID = "toDeviceLogin"
        static let toGreetingSetupSegueID = "toGreetingSetup"
        static let toWifiSetupSegueID = "toWifiSetup"
        static let toDeviceSetupSegueID = "toDeviceSetup"
        static let toTimezoneSetupSegueID = "toTimezoneSetup"
    }
    
    struct Color {
        struct BG {
            static let snow: UIColor = UIColor.white
            static let richElectricBlue: UIColor = UIColor(red: 17/255, green: 158/255, blue: 217/255, alpha: 1.0)
            static let darkSlateGray: UIColor = UIColor(red: 50/255, green: 79/255, blue: 100/255, alpha: 1.0)
            static let mediumJungleGreen: UIColor = UIColor(red: 20/255, green: 44/255, blue: 61/255, alpha: 1.0)
            static let darkJungleGreen: UIColor = UIColor(red: 15/255, green: 29/255, blue: 39/255, alpha: 1.0)
            static let vermilionRed: UIColor = UIColor(red: 238/255, green: 66/255, blue: 56/255, alpha: 1.0)
            static let deepCarminePink: UIColor = UIColor(red: 238/255, green: 44/255, blue: 44/255, alpha: 1.0)
            static let carminePink: UIColor = UIColor(red: 235/255, green: 65/255, blue: 65/255, alpha: 1.0)
            static let yellowGreen: UIColor = UIColor(red: 129/255, green: 193/255, blue: 33/255, alpha: 1.0)
            static let aquaBlue: UIColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0)
            static let orange: UIColor = UIColor(red: 255/255, green: 87/255, blue: 25/255, alpha: 1.0)
            static let textBG: UIColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        }
        
        //Status Colors
        struct State {
            static let red: UIColor = UIColor(red: 223.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            static let yellow: UIColor = UIColor(red: 221.0/255.0, green: 223.0/255.0, blue: 13.0/255.0, alpha: 1.0)
            static let green: UIColor = UIColor(red: 85.0/255.0, green: 191.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        }
    }
    
    struct Bluetooth {
        static let BLE_Heart_Rate_Service_CBUUID = CBUUID(string: "0x180D")
        static let BLE_Heart_Rate_Measurement_Characteristic_CBUUID = CBUUID(string: "0x2A37")
        static let BLE_Body_Sensor_Location_Characteristic_CBUUID = CBUUID(string: "0x2A38")
    }
    
    struct CellNib {
        static let homeCell = "HomeItemCell"
        static let newsItemCell = "NewsItemCell"
        static let chatCell = "ChatCell"
    }
    
    struct Key {
        static let appName = "SmartMeter"
        
        static let lastLoginName = "lastLoginName"
        static let accessToken = "accessToken"
        
        static let lastDeviceUserName = "lastDeviceUserName"
        static let lastDevicePassword = "lastDevicePassword"
        static let rememberUserInfo = "rememberUserInfo"
        
        struct UserDefault {
            static let lastLoginUsername = "lastLoginUsername"
            static let accessToken = "accessToken"
        }
    }
    
    struct XMLrequest {
        static let getStationXML = """
        <Find orderBy="CompressionStation.createDate desc" >
            <CompressionStation>
                <sysId ne=""/>
            </CompressionStation>
        </Find>
        """
        
        static let getOperatorXML = """
        <Query>
            <Find  orderBy="Operator.createDate desc" >
                <Operator>
                    <sysId ne=""/>
                </Operator>
            </Find>
        </Query>
        """
        
        static let getNeuronXML = """
        <Query>
            <Find  orderBy="Neuron.createDate desc" >
                <Neuron>
                    <sysId ne=""/>
                </Neuron>
            </Find>
        </Query>
        """
        static let getMeterTypeXML = """
        <Query>
            <Find>
                <MeterType>
                <sysId ne=""/>
                </MeterType>
            </Find>
        </Query>
        """
        
        static let getMeterReadingByStationXML = """
        <Query>
            <Find orderBy="MeterReadings.readingTime desc">
                <MeterReadings>
                    <stationId>
                        {0}
                    </stationId>
                </MeterReadings>
                <CompressionStation>
                    <sysId>
                        {0}
                    </sysId>
                </CompressionStation>
            </Find>
        </Query>`,
        """
        static let getMeterReadingByIDXML = """
        <Query>
        <Find>
        <MeterReadings>
        <sysId>{0}</sysId>
        <stationId>
        <Ne></Ne>
        <as>var.stationId</as>
        </stationId>
        </MeterReadings>
        <CompressionStation>
        <sysId>var.stationId</sysId>
        </CompressionStation>
        </Find>
            </Query>`,
        """
        static let getMeterReadingUniqueByStationXML = """
        <Query>
            <Create>
                <MeterReadings>
                    <sisId>{sisId}</sisId>
                    <stationId>{stationId}</stationId>
                    <imagePath>{imagePath}</imagePath>
                    <createDate>{createDate}</createDate>
                    <unit>{unit}</unit>
                    <readingTime>{readingTime}</readingTime>
                </MeterReadings>
            </Create>
        </Query>
        `,
        """
        static let createMeterReadingXML = """
        <Query>
            <Create>
                <MeterReadings>
                    <stationId>station1</stationId>
                    <imagePath>Meter-30-ae-a4-2c-d1-1c-1541652104056.jpg</imagePath>
                    <createDate>[:$Now():]</createDate>
                    <unit>Cubic Feet</unit>
                    <readingValue>121</readingValue>
                    <readingTime>[:$Now():]</readingTime>
                </MeterReadings>
            </Create>
        </Query>
        `,
        """
        static let getMeterReadingByDateByStationXML = """
        <Query>
            <Find orderBy="MeterReadings.readingTime">
                <MeterReadings>
                    <stationId in="{2}"></stationId>
                    <readingTime>
                        <ge>
                            {0}
                        </ge>
                        <le>
                            {1}
                        </le>
                    </readingTime>
                </MeterReadings>
            </Find>
        </Query>
        """
    }
    
}

