# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{3,4} )
inherit distutils-r1

DESCRIPTION="Implementation of the PEP 3156 Event-Loop with Qt."
HOMEPAGE="http://pypi.python.org/pypi/quamash"

MY_P="Quamash"
SRC_URI="https://pypi.python.org/packages/51/a3/dbead5b502aebc840c3672fc5e8ec7ecb2ea443d3e8638d14996600cd1cd/Quamash-0.5.5.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	( || ( || ( dev-python/PyQt4 dev-python/PyQt5 ) dev-python/PySide ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"

python_compile_all() {
	if use doc; then
		emake -C doc html
	fi
	distutils-r1_python_compile
}

python_install_all() {
	use doc && local HTML_DOCS=doc/build/html/.
	distutils-r1_python_install_all
}


