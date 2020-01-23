pragma solidity ^0.5.11;

contract ERC20Basic {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function getName() public view returns (string memory) {}
    function getSymbol() public view returns (string memory) {}
    function getDecimals() public view returns (uint8) {}

    function totalSupply() public view returns (uint256) {}
    function balanceOf(address _owner) public view returns (uint256 balance) {}
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {}
    function transferFrom(address _from, address _to, uint256 _value)
        public
        returns (bool success)
    {}
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {}
    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {}

}

contract StandardToken is ERC20Basic {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 public _totalSupply;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        if (_value > 0) {
            allowed[msg.sender][_spender] = _value;
            emit Approval(msg.sender, _spender, _value);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom(address _from, address _to, uint256 _value)
        public
        returns (bool success)
    {
        if (allowed[msg.sender][_from] >= _value && _value > 0) {
            if (balances[_from] >= _value) {
                balances[_from] -= _value;
                balances[_to] += _value;
                allowed[msg.sender][_from] -= _value;
                emit Transfer(_from, _to, _value);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
}

contract MyToken is StandardToken {
    string public name;
    string public symbol;
    uint32 public decimals;

    constructor() public {
        name = "IMFToken";
        symbol = "IMFT";
        decimals = 0;
        _totalSupply = 100000000000;
        balances[msg.sender] = _totalSupply;
    }
}
