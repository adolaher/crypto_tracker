import CoinTile from '../../../app/javascript/react/components/CoinTile';

describe('CoinsTile', () => {
  let name,
    picture,
    body,
    wrapper;

  beforeEach(() => {
    wrapper = mount(
      <CoinTile
        name="BTC"
        picture="Something.url"
        body="Random words here"
      />
    )
  });

  it('renders a header tag with the coin title', () => {
    expect(wrapper.find('h2')).toIncludeText("BTC");
  })
  it('renders a div tag', () => {
    expect(wrapper.find('div')).toBePresent();
  })
})
