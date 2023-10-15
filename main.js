function valueAdd(parmas) {
  switch (parmas) {
    case "valueAdd":
      fetch("counter.ashx?f=1")
        .then(() =>
          fetch("./upload/f1.txt")
            .then((data) => data.text())
            .then((res) => (document.getElementById("value").innerHTML = res))
        )
        .catch((err) => console.log(err));
      break;
  }
}
