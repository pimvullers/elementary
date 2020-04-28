# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Wallpapers for elementary OS"
HOMEPAGE="https://github.com/elementary/wallpapers"
SRC_URI="https://github.com/elementary/wallpapers/archive/${PV}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/wallpapers-${PV}

src_compile() { :; }
src_test() { :; }

src_install() {
	insinto /usr/share/backgrounds/elementary
	doins ./backgrounds/*.jpg

	dodir /usr/share/backgrounds
	dosym "elementary/Pablo Garcia Saldana.jpg" /usr/share/backgrounds/elementaryos-default
}
