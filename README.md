# Genjo!

This is the Genjo! application found at [https://www.genjo.net](http://www.genjo.net).

Genjo! is a language learner's best friend, and it's designed to make the 
process of learning a foreign language more manageable.

## License

Genjo is open source software and is licensed under the GNU General Public 
License v3.0. See [LICENSE.md](LICENSE.md) for more details.

## Getting Started

First of all, clone the repository and install the required gems.

```
$ bundle install --without production
```

Then you will need to migrate the database.

```
$ rails db:migrate
```

To ensure that everything worked, run the test suite.

```
$ rails test
```

Then start the server.

```
$ rails server
```
