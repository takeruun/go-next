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
          <UserForm/>
        </div>
      </main>
    </div>
  )
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
      .post('htpp://localhost:8080/users/')
      .set("content-type", "application/json")
      .send({ name: this.state.name, email: this.state.email })
      .end((err, res) => {
        console.log(res)
      })
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