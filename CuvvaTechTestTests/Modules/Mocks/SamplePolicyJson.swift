//
//  SamplePolicyJson.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

var jsonTestData: String = """
[
{
  "type": "policy_created",
  "timestamp": "2019-01-18T10:15:29.979Z",
  "unique_key": "policy:dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
  "payload": {
    "user_id": "user_000000BSJ47k7mKYfWUhkWOrxLYGm",
    "user_revision": "dev_profilerev_000000Bali5AZE5CMFSW3JWGClpxY",
    "policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
    "original_policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
    "reference_code": "PP32DFCS5W",
    "start_date": "2019-01-18T10:15:30.000Z",
    "end_date": "2019-04-18T11:15:30.000Z",
    "incident_phone": "+442038287127",
    "vehicle": {
      "vrm": "LB07SEO",
      "prettyVrm": "LB07 SEO",
      "make": "Volkswagen",
      "model": "Polo",
      "variant": "SE 16V",
      "color": "Silver"
    },
    "documents": {
      "certificate_url": "https://cuvva-documents-dev.s3.eu-west-1.amazonaws.com/documents",
      "terms_url": "https://cuvva-documents-dev.s3.eu-west-1.amazonaws.com/standard-documents"
    }
  }
},
{
  "type": "policy_financial_transaction",
  "timestamp": "2019-01-18T10:15:32.250Z",
  "unique_key": "transaction:dev_tx_000000BansDm7JjbiFjqm6TTTFPdo",
  "payload": {
    "policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
    "pricing": {
      "underwriter_premium": 499,
      "commission": 166,
      "total_premium": 665,
      "ipt": 80,
      "ipt_rate": 1200,
      "extra_fees": 125,
      "vat": 0,
      "deductions": 0,
      "total_payable": 870
    }
  }
},
{
  "type": "policy_cancelled",
  "timestamp": "2019-02-04T12:04:48.669Z",
  "unique_key": "cancellation:dev_polcancel_000000BbULyVLNP373NfaUxX4U4Ke",
  "payload": {
    "policy_id": "dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
    "type": "void",
    "new_end_date": null
  }
}
]
"""

var jsonTestDataEmptyPayload: String = """
[
{
  "type": "policy_created",
  "timestamp": "2019-01-18T10:15:29.979Z",
  "unique_key": "policy:dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe",
  "payload": {
  }
}
]
"""
