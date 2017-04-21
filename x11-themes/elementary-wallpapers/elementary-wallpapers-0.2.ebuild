# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A set of wallpapers used by the elementary OS"
HOMEPAGE="http://www.elementaryos.org/journal/luna-wallpapers-officially-revealed"
SRC_URI="https://launchpad.net/elementaryos/0.2-luna/luna-wallpapers/+download/luna-wallpapers.tar.gz"

LICENSE="CC-BY-NC-SA-2.5 CC-BY-3.0 CC-BY-NC-ND-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	default
}

src_install() {
	insinto /usr/share/backgrounds/elementary
	doins *.jpg

	dodir /usr/share/backgrounds
	dosym elementary/94.jpg /usr/share/backgrounds/elementaryos-default
}
