import React, { Component } from 'react';
import CoinTile from '../components/CoinTile';

class CoinsIndexContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      coins: [],
      searchText: '',
      searchResults: []
    }
    this.searchTextChange = this.searchTextChange.bind(this)
    this.formSubmit = this.formSubmit.bind(this)
  }

  searchTextChange(event) {
    this.setState({searchText: event.target.value});
  }

  formSubmit(event) {
    event.preventDefault()
    this.setState({searchResults: []})
    let previousSearch = [];
    let resultsOfSearch = [];
    this.state.coins.map(coin => {
      if (coin.name.startsWith(this.state.searchText)){
        previousSearch = resultsOfSearch
        resultsOfSearch = previousSearch.concat(coin)
      }
    })
    this.setState({searchResults: resultsOfSearch})
  }

  componentDidMount() {
    fetch('/api/coins')
    .then(response => response.json())
    .then(body => {
      let jsonCoins = body
      this.setState({ coins: jsonCoins })
    })
  }


  render() {
    let searchBy;
    if (this.state.searchResults.length == 0){
      searchBy = this.state.coins
    }else {
      searchBy = this.state.searchResults
    }

    let searchResults = searchBy.map(coin => {
      return(
        <div classname="tile">
        <CoinTile
          key={coin.id}
          id={coin.id}
          name={coin.name}
          picture={coin.picture}
          body={coin.description}
        />
        </div>
      )
    })

    let searchBar = (
          <form onSubmit={this.formSubmit} className='search'>
            <label> Search Coins
              <input
                name="searchText"
                type="text"
                value={this.state.searchText}
                onChange={this.searchTextChange}
                placeholder="Case Sensitive"
              />
            </label>
            <input className="button" type="submit" value="Submit"/>
          </form>
        )

    return(
      <div className="row">
          <ul>
              <div>{searchBar}</div>
              <h1>{searchResults}</h1>
          </ul>
          <a className="rlink" href="/coins/new"> Add New Coin </a>
      </div>
    )
  }
}

export default CoinsIndexContainer;
