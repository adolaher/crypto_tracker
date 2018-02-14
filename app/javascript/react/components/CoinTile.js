import React from 'react';

const CoinTile = (props) => {
  let coinLink = "/coins/" + props.id
  return(
    <div className="small-10 medium-4 large-4 columns">
    <div className="coin-tile">
    <a href={coinLink}>
        <h2> {props.name} </h2>
        <img src={props.picture} alt="coin"  className='image' height="200px" width="125px"/>
        <p> {props.body} </p>
    </a>
    </div>
    </div>
  )
}
export default CoinTile;
