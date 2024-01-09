use std::os::linux::net;

use boltz_client::swaps::bitcoin::BtcSwapScript;
// use boltz_client::network::electrum::NetworkConfig;
// use boltz_client::swaps::boltz;
use boltz_client::swaps::boltz::BoltzApiClient;
use boltz_client::swaps::boltz::CreateSwapRequest;
use boltz_client::swaps::boltz::SwapStatusRequest;
use boltz_client::util::error::ErrorKind;
use boltz_client::util::error::S5Error;
use boltz_client::util::preimage::Preimage;

use crate::types::BtcLnSwap;
use crate::types::BoltzError;
use crate::types::Network;
use crate::types::SwapType;
use crate::types::KeyPair;
use crate::types::PreImage;

pub struct Api {}

impl Api {

    pub fn swap_fees(boltz_url: String)->anyhow::Result<(f64,f64), BoltzError>{
        let boltz_client = BoltzApiClient::new(&boltz_url);
        // let network_config = NetworkConfig::new(network.into(), &electrum_url, true, true, false, None);
        match boltz_client.get_fee_estimation() {
            Ok(result)=>Ok((result.btc, result.lbtc)),
            Err(e)=> return Err(e.into())
        }
        
    }
    pub fn new_btc_ln_submarine(        
        mnemonic: String,
        index: u64,
        invoice: String,
        network: Network,
        electrum_url: String,
        boltz_url: String,
    ) -> anyhow::Result<BtcLnSwap,BoltzError>{
            let swap_type = SwapType::Submarine;
            let refund_keypair = match KeyPair::new(mnemonic, index, swap_type.clone()) {
                Ok(keypair) => keypair,
                Err(err) => return Err(err.into()),
            };
            let boltz_client = BoltzApiClient::new(&boltz_url);
            // let network_config = NetworkConfig::new(network.into(), &electrum_url, true, true, false, None);
            let boltz_pairs = match boltz_client.get_pairs() {
                Ok(result)=>result,
                Err(e)=> return Err(e.into())
            };

            let pair_hash = match boltz_pairs
            .pairs
            .pairs
            .get("BTC/BTC")
            .map(|pair_info| pair_info.hash.clone()){
                Some(result)=>result,
                None=> return Err(S5Error::new(ErrorKind::BoltzApi, "Could not find BTC/BTC pair-hash from boltz response").into())
            };

            let swap_request = CreateSwapRequest::new_btc_submarine(pair_hash, invoice.clone(), refund_keypair.clone().public_key);
            let response = match boltz_client.create_swap(swap_request){
                Ok(result)=>result,
                Err(e)=>return Err(e.into())
            };
            let preimage = match Preimage::from_invoice_str(&invoice){
                Ok(result)=>result,
                Err(e)=>return Err(e.into())
            };

            if !response.validate_script_preimage160(preimage.hash160){
                return Err(S5Error::new(ErrorKind::BoltzApi, "Preimage used in response invoice does not match! Report to support!").into());
            }
            let btc_swap_script = BtcSwapScript::submarine_from_str(&response.clone().redeem_script.unwrap()).unwrap();
        
            let payment_address = match btc_swap_script.to_address(network.clone().into()){
                Ok(result)=>result.to_string(),
                Err(e)=>return Err(e.into())
            };

            if &payment_address != &response.clone().address.unwrap(){
                return Err(S5Error::new(ErrorKind::BoltzApi, "Payment address in response does not match constructed script! Report to support!").into());
            }

            Ok(BtcLnSwap::new(
                response.clone().id,
                swap_type,
                network,
                refund_keypair,
                preimage.into(),
                response.clone().redeem_script.unwrap(),
                invoice,
                response.clone().expected_amount.unwrap(),
                response.clone().address.unwrap(),
                electrum_url,
                boltz_url,
            ))

    }
    
    pub fn swap_status(boltz_url: String, id: String)->anyhow::Result<String, BoltzError>{
        let boltz_client = BoltzApiClient::new(&boltz_url);
        // let network_config = NetworkConfig::new(network.into(), &electrum_url, true, true, false, None);
        match boltz_client.swap_status(SwapStatusRequest{id: id}) {
            Ok(result)=>Ok(result.status),
            Err(e)=> return Err(e.into())
        }
    }
    

}

// flutter_rust_bridge_codegen --rust-input rust/src/api.rs --dart-output lib/bridge_generated.dart --dart-decl-output lib/bridge_definitions.dart
