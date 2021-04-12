import Head from 'next/head'
import React from 'react'
import request from 'superagent'
import styles from '../styles/Home.module.css'

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>GO NEXT APP</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={styles.main}>
        <h1 className={styles.title}>
          Welcome to <a href="/">Go Next app</a>
        </h1>
        <div>
          <UserForm />
        </div>
        <br />
        <p>-----------------------------</p>
        <div>
          <Users />
        </div>
      </main>
    </div>
  );
}

class UserForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {name: '', email: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event){
    var name = this.state.name;
    var email = this.state.email;

    switch(event.target.name) {
      case 'name':
        name = event.target.value;
        break;
      case 'email':
        email = event.target.value;
        break;
    }

    this.setState({ name: name, email: email })
  }

  handleSubmit(event){
    request
      .post('http://localhost:8080/users')
      .set("Content-Type", "application/json")
      .send({ name: this.state.name, email: this.state.email })
      .end((err, res) => {
        console.log(res)
      });
    this.setState({ name: '', email: '' });
    event.preventDefault();
  }

  render(){
    return(
      <form onSubmit={this.handleSubmit}>
        <label>
          name:
          <input type="text" name="name" value={this.state.name} onChange={this.handleChange}></input>
        </label>
        <br/>
        <label>
          email:
          <input type="email" name="email" value={this.state.email} onChange={this.handleChange}></input>
        </label>
        <br/>
        <input type="submit" value="Submit" />
      </form>
    )
  }
}

class Users extends React.Component {
  constructor(props) {
    super(props);
    this.state = { users: [] };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    request
      .get('http://localhost:8080/users')
      .end((err, res) => {
        this.setState({ users: res.body.users })
      });
  }

  renderUserLists() {
    return this.state.users.map((user, index) => {
      return (
        <div key={index}>
          <li>
            <ul>
              {user.name}
            </ul>
            <ul>
              {user.email}
            </ul>
            <ul>
              {user.created_at}
            </ul>
          </li>
        </div>
      );
    })
  }

  render() {
    return (
      <React.Fragment>
      <button onClick={this.handleClick}>get users</button>
      {(() => {
        if (this.state.users) return <ul>{this.renderUserLists()}</ul>;
      })()}
    </React.Fragment>
    );
  }
}